# Environment variable (default: production)
ENV ?= production

.PHONY: all install clean format analyze test build-runner gen-assets build-apk build-appbundle build-ios run run-env pod-install gradle-clean help

# Default target
all: install gen-assets build-runner

# Install dependencies
install:
	flutter pub get

# Clean project
clean:
	flutter clean

# Format code
format:
	flutter format .

# Analyze code
analyze:
	flutter analyze

# Run tests
test:
	flutter test

# Generate code with build_runner
build-runner:
	flutter pub run build_runner build --delete-conflicting-outputs

# Generate assets with flutter_gen
gen-assets:
	flutter pub run flutter_gen

# Build APK for Android (use ENV=development/staging/production)
build-apk:
	flutter build apk --release --split-per-abi --flavor $(ENV) -t lib/main_$(ENV).dart

# Build App Bundle for Android (use ENV=development/staging/production)
build-appbundle:
	flutter build appbundle --flavor $(ENV) -t lib/main_$(ENV).dart

# Build iOS IPA (use ENV=development/staging/production)
build-ios:
	flutter build ipa --flavor $(ENV) -t lib/main_$(ENV).dart

# Run app with specified environment (use ENV=development/staging/production)
run-env:
	flutter run --flavor $(ENV) -t lib/main_$(ENV).dart

# Convenience targets for different environments
build-apk-dev:
	$(MAKE) build-apk ENV=development

build-apk-staging:
	$(MAKE) build-apk ENV=staging

build-apk-prod:
	$(MAKE) build-apk ENV=production

build-appbundle-dev:
	$(MAKE) build-appbundle ENV=development

build-appbundle-staging:
	$(MAKE) build-appbundle ENV=staging

build-appbundle-prod:
	$(MAKE) build-appbundle ENV=production

build-ios-dev:
	$(MAKE) build-ios ENV=development

build-ios-staging:
	$(MAKE) build-ios ENV=staging

build-ios-prod:
	$(MAKE) build-ios ENV=production

run-dev-env:
	$(MAKE) run-env ENV=development

run-staging-env:
	$(MAKE) run-env ENV=staging

run-prod-env:
	$(MAKE) run-env ENV=production

# Run development flavor
run-dev:
	flutter run --flavor development -t lib/main_development.dart

# Run staging flavor
run-staging:
	flutter run --flavor staging -t lib/main_staging.dart

# Run production flavor
run-prod:
	flutter run --flavor production -t lib/main_production.dart

# Install iOS dependencies
pod-install:
	cd ios && pod install

# Clean Android build
gradle-clean:
	cd android && ./gradlew clean

# Show available commands
help:
	@echo "Available commands:"
	@echo "  all             - Install dependencies, generate assets and code"
	@echo "  install         - Install Flutter dependencies"
	@echo "  clean           - Clean Flutter project"
	@echo "  format          - Format code"
	@echo "  analyze         - Analyze code"
	@echo "  test            - Run tests"
	@echo "  build-runner    - Generate code with build_runner"
	@echo "  gen-assets      - Generate assets with flutter_gen"
	@echo "  build-apk       - Build APK for Android (ENV=production)"
	@echo "  build-appbundle - Build App Bundle for Android (ENV=production)"
	@echo "  build-ios       - Build iOS IPA (ENV=production)"
	@echo "  run-env         - Run app with specified environment (ENV=production)"
	@echo "  run-dev         - Run development flavor"
	@echo "  run-staging     - Run staging flavor"
	@echo "  run-prod        - Run production flavor"
	@echo "  pod-install     - Install iOS dependencies"
	@echo "  gradle-clean    - Clean Android build"
	@echo "  help            - Show this help message"
	@echo ""
	@echo "Convenience build targets:"
	@echo "  build-apk-dev, build-apk-staging, build-apk-prod"
	@echo "  build-appbundle-dev, build-appbundle-staging, build-appbundle-prod"
	@echo "  build-ios-dev, build-ios-staging, build-ios-prod"
	@echo "  run-dev-env, run-staging-env, run-prod-env"
	@echo ""
	@echo "Usage examples:"
	@echo "  make build-apk ENV=staging"
	@echo "  make build-ios-dev"
	@echo "  make run-prod-env"