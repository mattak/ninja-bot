# Description:
#   Ninja Slyer Commands.
#
# Commands:
#   hubot hello - アイサツは神聖不可侵の行為。古事記にもそう書かれている。アイサツされれば返さねばならない。
#   hubot fight - Buttle with ninja.

romaji2katakana = (romaji) ->
  dictionary = {
    "fa" : "ファ" ,
    "fi" : "フィ" ,
    "fe" : "フェ" ,
    "fo" : "フォ" ,
    "kya" : "キャ" ,
    "kyu" : "キュ" ,
    "kyo" : "キョ" ,
    "sha" : "シャ" ,
    "shu" : "シュ" ,
    "sho" : "ショ" ,
    "tya" : "チャ" ,
    "tyu" : "チュ" ,
    "tyo" : "チョ" ,
    "nya" : "ニャ" ,
    "nyu" : "ニュ" ,
    "nyo" : "ニョ" ,
    "hya" : "ヒャ" ,
    "hyu" : "ヒュ" ,
    "hyo" : "ヒョ" ,
    "mya" : "ミャ" ,
    "myu" : "ミュ" ,
    "myo" : "ミョ" ,
    "rya" : "リャ" ,
    "ryu" : "リュ" ,
    "ryo" : "リョ" ,
    "fya" : "フャ" ,
    "fyu" : "フュ" ,
    "fyo" : "フョ" ,
    "pya" : "ピャ" ,
    "pyu" : "ピュ" ,
    "pyo" : "ピョ" ,
    "bya" : "ビャ" ,
    "byu" : "ビュ" ,
    "byo" : "ビョ" ,
    "dya" : "ヂャ" ,
    "dyu" : "ヂュ" ,
    "dyo" : "ヂョ" ,
    "ja" : "ジャ" ,
    "ju" : "ジュ" ,
    "jo" : "ジョ" ,
    "gya" : "ギャ" ,
    "gyu" : "ギュ" ,
    "gyo" : "ギョ" ,
    "pa" : "パ" ,
    "pi" : "ピ" ,
    "pu" : "プ" ,
    "pe" : "ペ" ,
    "po" : "ポ" ,
    "ba" : "バ" ,
    "bi" : "ビ" ,
    "bu" : "ブ" ,
    "be" : "ベ" ,
    "bo" : "ボ" ,
    "da" : "ダ" ,
    "di" : "ヂ" ,
    "du" : "ヅ" ,
    "de" : "デ" ,
    "do" : "ド" ,
    "za" : "ザ" ,
    "zi" : "ジ" ,
    "zu" : "ズ" ,
    "ze" : "ゼ" ,
    "zo" : "ゾ" ,
    "ga" : "ガ" ,
    "gi" : "ギ" ,
    "gu" : "グ" ,
    "ge" : "ゲ" ,
    "go" : "ゴ" ,
    "wa" : "ワ" ,
    "wi" : "イ" ,
    "wu" : "ウ" ,
    "we" : "ウェ" ,
    "wo" : "ヲ" ,
    "ra" : "ラ" ,
    "ri" : "リ" ,
    "ru" : "ル" ,
    "re" : "レ" ,
    "ro" : "ロ" ,
    "ya" : "ヤ" ,
    "yu" : "ユ" ,
    "yo" : "ヨ" ,
    "ma" : "マ" ,
    "mi" : "ミ" ,
    "mu" : "ム" ,
    "me" : "メ" ,
    "mo" : "モ" ,
    "ha" : "ハ" ,
    "hi" : "ヒ" ,
    "hu" : "フ" ,
    "he" : "ヘ" ,
    "ho" : "ホ" ,
    "na" : "ナ" ,
    "ni" : "ニ" ,
    "nu" : "ヌ" ,
    "ne" : "ネ" ,
    "no" : "ノ" ,
    "ta" : "タ" ,
    "ti" : "チ" ,
    "tu" : "ツ" ,
    "te" : "テ" ,
    "to" : "ト" ,
    "sa" : "サ" ,
    "si" : "シ" ,
    "su" : "ス" ,
    "se" : "セ" ,
    "so" : "ソ" ,
    "ka" : "カ" ,
    "ki" : "キ" ,
    "ku" : "ク" ,
    "ke" : "ケ" ,
    "ko" : "コ" ,
    "a" : "ア" ,
    "i" : "イ" ,
    "u" : "ウ" ,
    "e" : "エ" ,
    "o" : "オ" ,
    "la" : "ァ" ,
    "li" : "ィ" ,
    "lu" : "ゥ" ,
    "le" : "ェ" ,
    "lo" : "ォ" ,
    "ke" : "ヶ" ,
    "ka" : "ヵ" ,
    "n" : "ン" ,
    "-" : "ー" ,
  }

  result = ""

  while romaji.length > 0
    word1 = romaji.substr(0,1)
    word2 = romaji.substr(0,2)
    word3 = romaji.substr(0,3)

    if dictionary[word3]
      result += dictionary[word3]
      romaji = romaji.substr(3)
    else if dictionary[word2]
      result = result + dictionary[word2]
      romaji = romaji.substr(2)
    else if dictionary[word1]
      result += dictionary[word1]
      romaji = romaji.substr(1)
    else
      result += word1
      romaji = romaji.substr(1)

  return result

ninjaRandom = (number) ->
  return Math.floor( Math.random() * (number + 1) )

ninjaAttackerSay = (msg, user, content) ->
  msg.send "#{ user.name }=サン(#{ user.hp }): 「#{ content }」"

ninjaRandomSay = (msg, user, serifs) ->
  idx = ninjaRandom( serifs.length - 1 )
  serif = serifs[ idx ]
  ninjaAttackerSay(msg, user, serif)

ninjaButtle = (robot, msg, user1, user2) ->
  if user2.hp <= 0
    narrationSerifs = [
      "#{ user2.name }=サンはすでに息絶えている.",
      "#{ user2.name }=サンはスシを補給している.",
      "スシは高効率なエネルギー源であり、#{ user2.name }がもつ#{ user2.name }回復力を最大限に引き出す。",
    ]
    ninjaRandomSay msg, { name: 'ナレーション', hp: 1000, type: 'narrator' }, narrationSerifs
    return true

  attackPoint = ninjaRandom(user1.attack)
  hp = user2.hp - attackPoint
  if hp > 0
    user2.hp = hp
  else
    user2.hp = 0
  ninjaSave(robot, user2.nick, user2)

  # attaker
  attackerSerif = [
    "貴様はオフィスの床を汚したため、生かしてはおかん",
    "通りすがりだ。だが、貴様は殺す。",
    "当然、オヌシを殺しに来た。",
    "さあ#{ user2.name }=サン、インタビューの続きだ",
    "#{ user2.name }。殺すべし",
    "イヤーッ！",
    "ハイーッ！",
    "キリステ・ゴーメン",
    "ヤッチマエー！",
    "ナムサン！",
    "答えろ。なぜ#{ user1.name }を探している.",
    "ならば殺す。慈悲はない。",
    "ハイクを詠むがいい、#{ user2.name }=サン",
  ]
  ninjaRandomSay msg, user1, attackerSerif

  # defender
  if user2.hp > 0
    defenderSerif = [
      "アイエエエエエ！！",
      "グワーッ",
      "フンハー！",
      "オトナをナメるなよ・・・スッゾオラー！",
      "ザッケンナコラー！",
      "#{ user1.name }だと・・・奴がなぜ・・・",
      "一時休戦だ",
      "奴はシャレがわからねえな",
      "さすが高い偏差値！",
      "ヒッ",
      "アイエエエ暴力！",
      "チタン製胴当てを、空手チョップだけで叩き割りやがった。",
      "恐るべき、ジュー・ジツだ。",
      "アバッ・・・こんな事！俺は#{ user2.name }なのに・・・#{ user2.name }なのに・・・",
      "#{ user1.name.substr(0,1) }、#{ user1.name }=サン、も、申し訳ありません。"
    ]
    ninjaRandomSay msg, user2, defenderSerif
  else
    defenderSerif = [
      "嫌だ。死にたくない。こんなの間違いだ。",
      "インガオーホー！",
    ]
    ninjaRandomSay msg, user2, defenderSerif

  # narration
  narrationSerif = [
    "すると・・・何たる超自然現象！",
    "#{ user2.name }は痙攣しながら数歩後ろに下がった。",
    "ヘルメットはもはやグシャグシャに歪み、スクラップめいていた。",
    "ヘルメット内蔵のUNIX回路がスパークし、火花が散った。",
    "#{ user2.name }=サンは両腕付け根から血を噴き出し、へたり込んだ。",
    "握力が失われ、ダガーナイフが音を立てて床に転がった。",
    "ナムアミダブツ！",
    "マルノウチはネオサイタマの中でも比較的ハイ・ソサイエティな地域とされる.",
    "#{ user2.name }はジャンプで追い、空中膝落としで追撃！",
    "#{ user2.name }はキモノ店のショーウィンドウに手をつき、こらえた。",
    "#{ user2.name }の網膜HUDがそのさまを照準で囲み、「スシ」「スシを食べている」「スシを補給している」というステータス表示を高速で展開した。",
    "その時、#{ user2.name }に備わった高性能UNIXレーダーが異常を検知する。",
    "ザゼン中毒者がみるたちの悪い悪夢のように。",
    "#{ user2.name }はUNIXで分析を試みる。",
    "屋根の上から無慈悲なるカラテを叩き込んだ。",
    "アブナイ！いかな#{ user2.name }とて、銃弾の直撃を受ければただではすむまい！",
    "二十四時間常にウシミツ・アワーのごとき静けさだ。",
  ]
  ninjaRandomSay msg, { name: "ナレーション", hp: 1000, type: 'narrator' }, narrationSerif

  # deth check
  if user2.hp <= 0
    if boss
      if Math.floor( Math.random() * 10) == 0
        ninjaAttackerSay msg, user2, "サヨナラ。"
        return true
      else
        ninjaAttackerSay msg, user2, "ニンポ、シニフリのジツデス。"
        return false
    else
      ninjaAttackerSay msg, user2, "グワー!"
      return true

#  # attacker
#  if user2.hp == 50
#    ninjaAttackerSay msg, user1, "腕がなくなって寂しいか？"
#  else if user2.hp == 40

  return false

ninjaSave = (robot, name, player) ->
  robot.brain.data[name] = player
  robot.brain.save()

ninjaPlayer = (robot, nick) ->
  console.log "ninja player start"
  if robot.brain.data[nick]
    player = robot.brain.data[nick]
  else
    player = {
      nick: nick
      nick: romaji2katakana(nick)
      hp: 100
      attack: 50
      boss: false
      type: 'player'
    }
  player['boss'] = robot.name is nick
  player['nick'] = nick
  player['name'] = romaji2katakana(nick)
  player['type'] = 'player'
  ninjaSave robot, nick, player
  return player

ninjaFight = (robot, msg, ninja, user) ->
  if !ninjaButtle(robot, msg, ninja, user)
    return ninjaButtle(robot, msg, user, ninja)
  return false

ninjaRestart = (robot, user) ->
  console.log "#{ user['nick'] } : #{ user['boss'] }"
  if user['boss'] is true
    user['hp'] = 200
    user['attack'] = 100
  else
    user['hp'] = 100
    user['attack'] = 50
  ninjaSave robot, user.nick, user

ninjaHello = (robot, msg, user1, user2) ->
  ninjaAttackerSay msg, user1, "ドーモ、#{ romaji2katakana( user2.name ) }＝サン。#{ user1.name }デス。"

module.exports = (robot) ->
  robot.respond /(HELLO|コンニチワ)$/i, (msg) ->
    ninja = ninjaPlayer(robot, robot.name)
    user  = ninjaPlayer(robot, msg.message.user.name)
    ninjaRestart robot, user
    ninjaRestart robot, ninja
    console.log "ninja: #{ JSON.stringify(ninja) }"
    console.log "user: #{ JSON.stringify(user) }"
    ninjaHello robot, msg, ninja, user
    ninjaHello robot, msg, user, ninja
  robot.respond /fight/i, (msg) ->
    ninja = ninjaPlayer(robot, robot.name)
    user  = ninjaPlayer(robot, msg.message.user.name)
    console.log "ninja: #{ JSON.stringify(ninja) }"
    console.log "user: #{ JSON.stringify(user) }"
    process.exit 0 if ninjaFight robot, msg, ninja, user
  robot.respond /die$/i, (msg) ->
    ninja = ninjaPlayer(robot, robot.name)
    ninjaAttackerSay msg, ninja, "ニンポ、シニフリジツ。"
