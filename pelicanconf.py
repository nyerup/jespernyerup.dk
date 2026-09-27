#!/usr/bin/env python
# -*- coding: utf-8 -*- #

AUTHOR = 'Jesper Nyerup'
SITENAME = 'Jesper Nyerup'
SITEURL = ''
SITEDESCRIPTION = (
    'Personal site of Jesper Dahl Nyerup – engineering leader, unix '
    'technician, scout, and father, living just west of Copenhagen.'
)

THEME = '.'
THEME_STATIC_DIR = '.'

PAGE_SAVE_AS = '{slug}/index.html'
PAGE_URL = '{slug}/'

PATH = 'content'
PAGE_PATHS = ['.']

# This is a handful of static pages, not a blog. Turn off everything that
# generates article, feed, or taxonomy output.
ARTICLE_PATHS = []
INDEX_SAVE_AS = ''
TAGS_SAVE_AS = ''
TAG_SAVE_AS = ''
CATEGORIES_SAVE_AS = ''
CATEGORY_SAVE_AS = ''
ARCHIVES_SAVE_AS = ''
AUTHORS_SAVE_AS = ''
AUTHOR_SAVE_AS = ''

FEED_ALL_ATOM = None
CATEGORY_FEED_ATOM = None
TRANSLATION_FEED_ATOM = None
AUTHOR_FEED_ATOM = None
AUTHOR_FEED_RSS = None

TIMEZONE = 'Europe/Copenhagen'
DEFAULT_LANG = 'en'

# Uncomment following line if you want document-relative URLs when developing
#RELATIVE_URLS = True
