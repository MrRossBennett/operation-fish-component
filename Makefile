# Node Modules for CSS
NODE_SASS=node ./node_modules/.bin/node-sass

# Node Modules for JS
KARMA=NODE_ENV=test node ./node_modules/.bin/karma
STORYBOOK=node ./node_modules/.bin/start-storybook
STORYBOOK_BUILD_STATIC=node ./node_modules/.bin/build-storybook
WEBPACK=node ./node_modules/.bin/webpack

# Node Modules for Images
SVGO=node ./node_modules/.bin/svgo
SVG_SPRITE=node ./node_modules/.bin/svg-sprite

# Basepath Source
BASEPATH_SRC_CSS=./assets/css
BASEPATH_SRC_FONTS=./assets/fonts
BASEPATH_SRC_IMG=./assets/img

# Basepath Destinations
BASEPATH_DEST_CSS=./public_template/_css
BASEPATH_DEST_FONTS=./public_template/_fonts
BASEPATH_DEST_IMG=./public_template/_img
BASEPATH_DEST_STORYBOOK_STATIC=./public_template/storybook

# Vendor JS Files

build: clean fonts css images test storybook-build-static create-build-folder
build_prod: clean fonts css images create-build-folder

init:
	yarn

clean:
	@echo 'Cleaning up prebuilt directories'
	@rm -rf $(BASEPATH_DEST_CSS)
	@rm -rf $(BASEPATH_DEST_FONTS)
	@rm -rf $(BASEPATH_DEST_IMG)
	@rm -rf $(BASEPATH_DEST_STORYBOOK_STATIC)
	@echo 'Cleaned!'

create-build-folder:
	npm run build

css:
	@echo 'Building CSS'
	@mkdir -p $(BASEPATH_DEST_CSS)
	@$(NODE_SASS) $(BASEPATH_SRC_CSS) -o $(BASEPATH_DEST_CSS) --source-map $(BASEPATH_DEST_CSS)
	@node scripts/build.css.post.js --directory $(BASEPATH_DEST_CSS)/**/*
	@echo 'Finished building CSS'

fonts:
	@echo 'Copying fonts'
	@mkdir -p $(BASEPATH_DEST_FONTS)
	@cp -a $(BASEPATH_SRC_FONTS)/. $(BASEPATH_DEST_FONTS) || :
	@echo 'Finished copying fonts'

images:
	@echo 'Copying images'
	@mkdir -p $(BASEPATH_DEST_IMG)
	@cp -a $(BASEPATH_SRC_IMG)/. $(BASEPATH_DEST_IMG)
	@$(SVGO) -f $(BASEPATH_DEST_IMG)/svg --enable=removeTitle
	@rm -rf $(BASEPATH_DEST_IMG)/**/sprite.css.svg
	@$(SVG_SPRITE) --symbol --symbol-dest $(BASEPATH_DEST_IMG) $(BASEPATH_DEST_IMG)/**/*
	@echo 'Finished copying images'

storybook:
	@echo 'Running storybook'
	@$(STORYBOOK) -p 9001

storybook-build-static:
	@echo 'Building static version of storybook'
	@$(STORYBOOK_BUILD_STATIC) -o $(BASEPATH_DEST_STORYBOOK_STATIC)

test:
	@echo 'Running tests'
	@$(KARMA) start --single-run
	@echo 'Finished running tests'
