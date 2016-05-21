dotenv = require('dotenv')
dotenv.load();

slack_hook_url = process.env.SLACK_HOOK_URL

url = require('url')
http = require('http')
https = require('https')
webhookUrl = url.parse(slack_hook_url)
webhookOptions =
  hostname: webhookUrl.hostname
  path: webhookUrl.path
  port: 443
  method: 'POST'
  headers: 'Content-Type': 'application/json'

exports.handler = (event, context) ->
  array = [
    ## マーク・トゥエイン
    '真実をしゃべるなら\n何も覚えておかなくていい。\n- Mark Twain -'
    'やったことは例え失敗しても\n20年後には笑い話にできる。\nしかしやらなかったことは\n20年後には後悔するだけだ。\n- Mark Twain -'
    '自分が多数派の側にいると気づいたら\nもう意見を変えてもいいころだ。\n- Mark Twain -'
    '人類は一つの\nとても効果的な武器をもっている。\nそれは笑いだ。\n- Mark Twain -'
    '人生で必要なものは\n無知と自信だけだ。\nこれだけで成功は間違いない。\n- Mark Twain -'
    ## トム・デマルコ
    '誰もが「やればできる」精神で仕事をするように強いられる。それが問題なのだ。リスクを口に出すことは「できない」精神のあらわれである。リスク発見は、組織のこのような基本姿勢とまったく相容れないものである。- Tom DeMarco 熊とワルツを P.136 http://amzn.to/1SOn42M -',
    ## サーバント・リーダーシップ
    #http://president.jp/articles/-/15523
    '傾聴: 相手が望んでいることを聞き出すために、まずは話をしっかり聞きどうすれば役に立てるか考えているか。また、自分の心の声に対しても耳を傾けているか。',
		'共感: 相手の立場に立って相手の気持ちを理解しているか。人は不完全であるという前提に立ち、相手をどんなときも受け入れているか。',
		'癒やし: 相手の心を無傷の状態にして、本来の力を取り戻させることができているか。組織や集団においては、欠けている力を補い合えるようにすること。',
		'気付き: ものごとをありのままに見ることによって、気付きを得ることができているか。これにより相手に気付きを与えることもできるはずだ。',
		'納得: 相手のコンセンサスを得ながら納得を促すことができているか。権限に頼って服従を強要しないこと。',
		'概念化: 大きな夢やビジョナリーなコンセプトを持ち、それを相手に伝えることができているか。',
		'先見力: 現在の出来事を過去の出来事と照らし合わせ、そこから将来の出来事を予想できているか。',
		'執事役: 自分が利益を得ることよりも、相手に利益を与えることに喜びを感じているか。一歩引くことも心得ること。',
		'人々の成長への関与: 仲間の成長を促すことに深くコミットしているか。一人ひとりが秘めている力や価値に気付いているか。',
		'コミュニティづくり: 愛情と癒やしで満ちていて、人々が大きく成長できるコミュニティをつくり出せているか。',
    ## ニーチェの言葉
    '自己表現とは自分の力を表すことでもある。その方法を大きく分けると、次の三つになる。\n贈る。\nあざける。\n破壊する。\n相手に愛や慈しみを贈るのも、自分の力の表現だ。相手をけなし、いじめ、ダメにしてしまうのも、自分の力の表現だ。あなたはどの方法をとっているのか。', #自分を表す三つの形
    ## イェイツ
    'In dreams begin the responsibilities.\n夢を持つには責任も伴う  \n- ウィリアム・バトラー・イェイツ -',
    ## Scrum
    #original
    'デイリースクラムが検査と適応のセレモニーになっているか？\n高速なフィードバックサイクルを回すことで問題を早期に発見する為のものだ。'
  ]
  random_size = Math.floor(Math.random() * array.length)
  res_text = array[random_size]
  res_json = JSON.stringify(
    channel: '#_spike3'
    username: 'Suggest Bot'
    icon_emoji: ':tophat:'
    text: res_text)
  console.log res_json
  req = https.request(webhookOptions, (res) ->
    res.setEncoding 'utf8'
    res.on 'data', (chunk) ->
      console.log chunk
      context.succeed()
      return
    return
  ).on('error', (e) ->
    console.log 'error: ' + e.message
    return
  )
  req.write res_json
  req.end()
  return
