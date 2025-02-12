USER  ?= dianaflorezbravo@gmail.com
PASS  ?= t0dWILFMd46vG9BA
MONGODB_ATLAS ?= mongodb+srv://dianaflorezbravo:t0dWILFMd46vG9BA@dianaflorez.am8hq.mongodb.net/?retryWrites=true&w=majority&appName=dianaflorez

# Init Scripts
.PHONY: dev-api
dev-api:
	cd api && npm run dev

.PHONY: dev-ui
dev-ui:
	cd ui && npm run dev

.PHONY: dev-ui-build
dev-ui:
	cd ui && npm run build

.PHONY: dev-start
dev-start: 
	make -j 3 mongo-start dev-api dev-ui

# DB Scripts
.PHONY: dev-populate-data
dev-populate-data:
	cd scripts && ./mongoimport.sh

.PHONY: dev-delete-data
dev-delete-data:
	cd scripts && ./mongodelete.sh

.PHONY: mongo-start
mongo-start:
	cd scripts && ./mongostart.sh

.PHONY: mongo-export
mongo-export:
	cd scripts && ./mongoexport.sh


.PHONY: dev-bbdd-start-populate
dev-bbdd-start-populate: mongo-start dev-populate-data

.PHONY: generate-password
generate-password:
	cd scripts && ./generatepass.sh $(USER) $(PASS)

.PHONY: import-atlass
import-atlass:
	cd scripts && ./mongoimportatlass.sh $(MONGODB_ATLAS)

# Installation scripst
.PHONY: install-ui
install-ui:
	cd ui && npm install

.PHONY: install-backend
install-backend:
	cd api && npm install

.PHONY: install-dependencies
install-dependencies: install-ui install-backend