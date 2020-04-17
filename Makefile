ifndef BUILD_ROOT
BUILD_ROOT = .
endif
DOC_FILES = index.md service.md about.md release.md recruit.md

all: web_ja web_en

$(BUILD_ROOT)/markdown_i18n: $(BUILD_ROOT)/markdown_i18n.c
	$(CC) $(CFLAGS) -o $@ $^

web_en: $(BUILD_ROOT)/markdown_i18n
	for x in $(DOC_FILES);	\
	do \
	  $(BUILD_ROOT)/markdown_i18n -l en	\
	    -f $(BUILD_ROOT)/html/$$x		\
	    -o $(BUILD_ROOT)/html/docs/$$x;		\
	done
	$(BUILD_ROOT)/markdown_i18n -l en	\
	  -f $(BUILD_ROOT)/html/mkdocs.yml	\
	  -o $(BUILD_ROOT)/html/mkdocs.en.yml
	pushd $(BUILD_ROOT)/html;		\
	env LANG=en_US.utf8			\
	  mkdocs build -c -f mkdocs.en.yml -d ../docs/en; \
	popd

web_ja: $(BUILD_ROOT)/markdown_i18n
	for x in $(DOC_FILES);	\
	do \
	  $(BUILD_ROOT)/markdown_i18n -l ja	\
	    -f $(BUILD_ROOT)/html/$$x		\
	    -o $(BUILD_ROOT)/html/docs/$$x;	\
	done
	$(BUILD_ROOT)/markdown_i18n -l ja	\
	  -f $(BUILD_ROOT)/html/mkdocs.yml	\
	  -o $(BUILD_ROOT)/html/mkdocs.ja.yml
	pushd $(BUILD_ROOT)/html;		\
	env LANG=ja_JP.utf8			\
	  mkdocs build -c -f mkdocs.ja.yml -d ../docs/; \
	popd
	echo -n heterodb.com > $(BUILD_ROOT)/docs/CNAME

