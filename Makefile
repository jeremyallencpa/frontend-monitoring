# Must have `sentry-cli` installed globally
# Following variables must be passed in
export SENTRY_AUTH_TOKEN=
SENTRY_ORG=ja-test
SENTRY_PROJECT=react-test
REACT_APP_RELEASE_VERSION=`sentry-cli releases propose-version`

setup_release:	create_release upload_sourcemaps associate_commits

create_release:
	sentry-cli releases -o $(SENTRY_ORG) new -p $(SENTRY_PROJECT) $(REACT_APP_RELEASE_VERSION)

upload_sourcemaps:
	sentry-cli releases -o $(SENTRY_ORG) -p $(SENTRY_PROJECT) files $(REACT_APP_RELEASE_VERSION) \
    	upload-sourcemaps --url-prefix "~/static/js" --validate build/static/js

associate_commits:
	sentry-cli releases -o $(SENTRY_ORG) -p $(SENTRY_PROJECT) set-commits --auto $(REACT_APP_RELEASE_VERSION)