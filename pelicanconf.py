#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

AUTHOR = u'Jesper Nyerup'
SITENAME = u'Jesper Nyerup'
SITEURL = ''

THEME = '.'
THEME_STATIC_DIR = '.'

PAGE_SAVE_AS = '{slug}/index.html'
PAGE_URL = '{slug}/'

# Disable blog stuff
INDEX_SAVE_AS = ''
TAGS_SAVE_AS = ''
CATEGORIES_SAVE_AS = ''
ARCHIVES_SAVE_AS = ''
AUTHORS_SAVE_AS = ''

PATH = 'content'
PAGE_PATHS = ['.']
ARTICLE_PATHS = ['articles']

TIMEZONE = 'Europe/Copenhagen'

DEFAULT_LANG = u'DA'

# Feed generation is usually not desired when developing
FEED_ALL_ATOM = None
CATEGORY_FEED_ATOM = None
TRANSLATION_FEED_ATOM = None
AUTHOR_FEED_ATOM = None
AUTHOR_FEED_RSS = None

# Blogroll
LINKS = ()

DEFAULT_PAGINATION = 10

# Uncomment following line if you want document-relative URLs when developing
#RELATIVE_URLS = True
