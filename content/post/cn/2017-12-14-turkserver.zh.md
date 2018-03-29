+++
highlight = true
math = false
date = "2017-10-29"
title = "2017年黑客马拉松之turkserver"
tags = ["news"]

summary = """TurkServer is a framework based on the JavaScript app platform Meteor that makes it easy to build interactive web-based user experiments for deployment on Amazon Mechanical Turk.
"""
[header]
image = "headers/bird3.svg"
caption = "Image credit: [**Academic**](https://github.com/gcushen/hugo-academic/)"
+++

turkserver

http://turkserver.readthedocs.io/

## Tutorials：quick start

http://turkserver.readthedocs.io/en/latest/quick-start.html

TurkServer/tutorial https://github.com/TurkServer/tutorial

- install meteor
- sign up AWS Account, get the id and secret.

浏览器歧视:
- 一个可以打开 http://localhost:3000/experiment
- 另一个打开 http://localhost:3000/turkserver

Oops, looks like there's no route on the client or the server for url: "http://localhost:3000/mturk/externalSubmit."

## mlab

https://mlab.com/

## azure

https://portal.azure.cn/

- chengjunwang@chengjunwang.partner.onmschina.cn
- Datalab2017


# error

chengjuns-MacBook-Pro:server chengjun$ MONGO_URL=mongodb://localhost:27017/test PORT=3000 ROOT_URL=http://localhost:3000 npm start

> meteor-dev-bundle@0.0.0 start /Users/chengjun/GitHub/tutorial/.demeteorized/bundle/programs/server
> node ../../main

/Users/chengjun/GitHub/tutorial/.demeteorized/bundle/programs/server/node_modules/fibers/future.js:313
						throw(ex);
						^

Error: failed to connect to [localhost:27017]
    at Object.Future.wait (/Users/chengjun/GitHub/tutorial/.demeteorized/bundle/programs/server/node_modules/fibers/future.js:449:15)
    at new MongoConnection (packages/mongo/mongo_driver.js:213:27)
    at new MongoInternals.RemoteCollectionDriver (packages/mongo/remote_collection_driver.js:4:16)
    at Object.<anonymous> (packages/mongo/remote_collection_driver.js:38:10)
    at Object.defaultRemoteCollectionDriver (packages/underscore/underscore.js:750:1)
    at new Mongo.Collection (packages/mongo/collection.js:103:40)
    at AccountsServer.AccountsCommon (packages/accounts-base/accounts_common.js:23:18)
    at new AccountsServer (packages/accounts-base/accounts_server.js:18:5)
    at meteorInstall.node_modules.meteor.accounts-base.server_main.js (packages/accounts-base/server_main.js:9:12)
    at fileEvaluate (packages/modules-runtime/.npm/package/node_modules/install/install.js:153:1)
    - - - - -
    at .<anonymous> (/Users/chengjun/GitHub/tutorial/.demeteorized/bundle/programs/server/npm/node_modules/meteor/npm-mongo/node_modules/mongodb/lib/mongodb/connection/server.js:556:25)
    at emitThree (events.js:116:13)
    at emit (events.js:194:7)
    at .<anonymous> (/Users/chengjun/GitHub/tutorial/.demeteorized/bundle/programs/server/npm/node_modules/meteor/npm-mongo/node_modules/mongodb/lib/mongodb/connection/connection_pool.js:156:15)
    at emitTwo (events.js:106:13)
    at emit (events.js:191:7)
    at Socket.<anonymous> (/Users/chengjun/GitHub/tutorial/.demeteorized/bundle/programs/server/npm/node_modules/meteor/npm-mongo/node_modules/mongodb/lib/mongodb/connection/connection.js:534:10)
    at emitOne (events.js:96:13)
    at Socket.emit (events.js:188:7)
    at emitErrorNT (net.js:1272:8)

npm ERR! Darwin 17.2.0
npm ERR! argv "/usr/local/bin/node" "/usr/local/bin/npm" "start"
npm ERR! node v6.2.2
npm ERR! npm  v3.9.5
npm ERR! code ELIFECYCLE
npm ERR! meteor-dev-bundle@0.0.0 start: `node ../../main`
npm ERR! Exit status 1
npm ERR!
npm ERR! Failed at the meteor-dev-bundle@0.0.0 start script 'node ../../main'.
npm ERR! Make sure you have the latest version of node.js and npm installed.
npm ERR! If you do, this is most likely a problem with the meteor-dev-bundle package,
npm ERR! not with npm itself.
npm ERR! Tell the author that this fails on your system:
npm ERR!     node ../../main
npm ERR! You can get information on how to open an issue for this project with:
npm ERR!     npm bugs meteor-dev-bundle
npm ERR! Or if that isn't available, you can get their info via:
npm ERR!     npm owner ls meteor-dev-bundle
npm ERR! There is likely additional logging output above.

npm ERR! Please include the following file with any support request:
npm ERR!     /Users/chengjun/GitHub/tutorial/.demeteorized/bundle/programs/server/npm-debug.log
chengjuns-MacBook
