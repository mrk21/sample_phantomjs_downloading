page = (require 'webpage').create()

callbacks = [
  -> # ログイン画面の処理
    page.evaluate ->
      document.getElementById('user').value = 'user'
      document.getElementById('pass').value = 'pass'
      
      e = document.createEvent('MouseEvents')
      e.initEvent('click',false,true)
      document.getElementById('submit').dispatchEvent(e)
  -> # ホーム画面の処理
    page.evaluate ->
      e = document.createEvent('MouseEvents')
      e.initEvent('click',false,true)
      document.getElementById('to_history').dispatchEvent(e)
  -> # 履歴画面の処理 -> CSVをダウンロードする！
    page.evaluate ->
      e = document.createEvent('MouseEvents')
      e.initEvent('click',false,true)
      document.getElementById('download').dispatchEvent(e)
]

page.onLoadFinished = ->
  callback = callbacks.shift()
  phantom.exit() unless callback
  callback()

# Content-Disposition: attachment なレスポンスが返された時に呼び出されるコールバック
page.onUnsupportedContentReceived = (response) ->
  page.saveUnsupportedContent('tmp/history.csv', response.id)

page.open "http://localhost:9292"
