# Must have `sentry-cli` installed globally
# Following variables must be passed in
export SENTRY_AUTH_TOKEN=529da5f044914c1b86843312c17ae88a6479c132f3ce4439af279d0cfdd642de
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