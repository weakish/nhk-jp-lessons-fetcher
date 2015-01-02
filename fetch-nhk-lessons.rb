#!/usr/bin/env ruby2.1

# by Jakukyo Friel <weakish@gmail.com> (http://weakish.github.io)

# This script automatically download all videos and textbook of
# [NHK Japanese lesson](http://www3.nhk.or.jp/lesson/english/download/index.html)
# to the current directory.

# It requires wget, nokogiri and of course ruby.

require 'rubygems'
require 'bundler/setup'

require 'open-uri'
require 'nokogiri'

nhk_site = 'http://www3.nhk.or.jp'
base_url = nhk_site + '/lesson/english/'

# download textbook

textbook_url = base_url + 'textbook_english.pdf'
system 'wget', textbook_url

# download audio

download_page = open base_url + 'download/index.html'
download_page_tree = Nokogiri::HTML.parse download_page.read
a_tags = download_page_tree.css '#mainCnt a'
links = a_tags.map { |link| link['href'] }
relative_mp3_links = links.select { |link| link =~ /\.mp3$/ }
mp3_download_links = relative_mp3_links.map { |link| nhk_site + link }
mp3_download_links.map { |link| system 'wget', link }

