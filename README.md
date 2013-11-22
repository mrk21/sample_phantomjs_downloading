sample_phantomjs_downloading
============================

PhantomJS にて Content-Disposition: attachment なレスポンスを取得するものである。
サーバー側は Rack を用いた。

## ファイル概要

+ `config.ru`:
  Rackアプリ
 
+ `***.html.erb`:
  Rackアプリで使うテンプレート

+ `download_csv.coffee`:
  PhantomJSスクリプト

## 使用方法

1. `$ rackup`とし、Rackアプリ を起動する

2. `$ phantomjs download_csv.coffee` とする

3. `tmp/history.csv`にサーバーからダウンロードしたCSVができる

※ ブラウザでアクセスする場合は、`http://localhost:9292`とする

## 依存ツール、ライブラリ

### Ruby

バージョン 1.9 以上

### PhantomJS

[本家から fork されたバージョンを用いている](https://github.com/woodwardjd/phantomjs/tree/add_download_capabilities)。1.6 がベースとなる。

    $ sudo yum install gcc gcc-c++ make git openssl-devel freetype-devel fontconfig-devel
    $ git clone https://github.com/woodwardjd/phantomjs.git
    $ cd phantomjs
    $ git checkout add_download_capabilities
    $ ./build.sh
    
    $ mv phantomjs add_download_capabilities
    $ sudo mkdir -p /usr/local/phantomjs/
    $ sudo mv add_download_capabilities /usr/local/phantomjs/
    
    $ sudo vi /etc/profile.d/phantomjs.sh
    vi> export PATH=/usr/local/phantomjs/add_download_capabilities/bin:${PATH}
    
    $ sudo vi /etc/ld.so.conf.d/phantomjs.conf
    vi> /usr/local/phantomjs/add_download_capabilities/src/qt/lib
    
    $ sudo ldconfig
