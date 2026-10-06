DOMAIN_NAME	= tbaricau.42.fr
VOLUMES		= /home/$(USER)/data
COMPOSE		= sudo docker compose -f ./srcs/docker-compose.yml

CLEARLINE	= \r\033[K
RESET		= \e[0m
BOLD		= \e[1m
RED			= \e[31m
GREEN		= \e[32m
YELLOW		= \e[33m
CYAN		= \e[36m
WHITE		= \e[37m
GREY		= \e[90m

define head
$(BOLD)$(GREY)[$(2)$(1)$(GREY)]$(RESET)
endef

HEAD_INFO		= $(call head,INFO,$(CYAN))
HEAD_SUCCESS	= $(call head,SUCCESS,$(GREEN))
HEAD_ERROR		= $(call head,ERROR,$(RED))

define step
	@printf "$(HEAD_INFO) $(1)..."; \
	out="$$( { $(2); } 2>&1 )"; \
	status="$$?"; \
	if [ "$$status" -eq 0 ]; then \
		printf "$(CLEARLINE)$(HEAD_SUCCESS) $(1)\n"; \
	else \
		printf "$(CLEARLINE)$(HEAD_ERROR) $(1)\n"; \
		printf "\n$$out\n\n"; \
		exit $$status; \
	fi
endef

define exec
	@printf "$(HEAD_INFO) $(1)...\n"; \
	$(2); \
	status="$$?"; \
	if [ "$$status" -eq 0 ]; then \
		printf "$(HEAD_SUCCESS) $(1)\n\n"; \
	else \
		printf "$(HEAD_ERROR) $(1)\n\n"; \
		exit $$status; \
	fi
endef

define log
	@printf "$(1) $(2)\n";
endef

all: up

up:
	$(call step,Adding '$(DOMAIN_NAME)' to hosts,sudo grep -q "$(DOMAIN_NAME)" /etc/hosts || echo "127.0.0.1 $(DOMAIN_NAME)" | sudo tee -a /etc/hosts)
	$(call step,Creating mariadb folder,sudo mkdir -p $(VOLUMES)/mariadb)
	$(call step,Creating wordpress folder,sudo mkdir -p $(VOLUMES)/wordpress)
	$(call exec,UP,$(COMPOSE) up --build -d)

down:
	$(call exec,DOWN,$(COMPOSE) down)

du: down up

start:
	$(call exec,Starting,$(COMPOSE) start)

stop:
	$(call exec,Stopping,$(COMPOSE) stop)

restart: stop start

clean:
	$(call exec,Cleaning volumes and images,$(COMPOSE) down -v --rmi all)
	$(call step,Removing mariadb folder,sudo rm -dfr $(VOLUMES)/mariadb)
	$(call step,Removing wordpress folder,sudo rm -dfr $(VOLUMES)/wordpress)
	$(call step,Removing '$(DOMAIN_NAME)' from hosts,sudo sed -i '/$(subst .,\.,$(DOMAIN_NAME))/d' /etc/hosts)

re: clean all

stats:
	@sudo docker stats

.PHONY: all up down start stop restart clean re stats
