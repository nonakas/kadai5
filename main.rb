# coding: utf-8
require 'dxruby'

require_relative 'player'
require_relative 'enemy'

k = 0
score = 0
start_flag = 0
font = Font.new(230)
font2 = Font.new(30)

Window.width  = 800
Window.height = 600

player_img = Image.load("speed_fast_rabbit.png")
player_img.setColorKey([0, 0, 0])

enemy_img = Image.load("maru1.png")
enemy_img.setColorKey([0, 0, 0])

enemy_img2 = Image.load("maru2.png")
enemy_img2.setColorKey([0, 0, 0])

enemy_img3 = Image.load("maru3.png")
enemy_img3.setColorKey([0, 0, 0])

player = Player.new(400, 400, player_img)

back = Image.load('bg_natural_sky.jpg')
start = Image.load('start.png')
rabbit1 = Image.load('rabbit1.png')
rabbit2 = Image.load('rabbit2.png')

clear = Image.load('clear.png')

enemies = []
enemies2 = []
enemies3 = []

1.times do
  enemies << Enemy.new(rand(800), 0, enemy_img)
  enemies2 << Enemy.new(rand(800), 0, enemy_img2)
  enemies3 << Enemy.new(rand(800), 0, enemy_img3)
end

Window.loop do
  Window.draw(-20, -20, start)
  break if Input.keyPush?(K_ESCAPE)
  Window.draw_font(0, 20,"お月見うさちゃんキャッチゲーム" ,font2)
  Window.draw_font(0, 80,"ルール説明" ,font2)
  Window.draw_font(0, 140,"うさちゃんはとてもお腹が空いている" ,font2)
  Window.draw_font(0, 200,"のでたくさんお月見団子を食べられる" ,font2)
  Window.draw_font(0, 260,"ようにうさぎを操作してください。",font2)
  Window.draw_font(0, 320,"スタート:[ESCキー]",font2)
  if start_flag < 100
    Window.draw(450, 200, rabbit1)
  elsif start_flag < 199
    Window.draw(450, 200, rabbit2)
  elsif start_flag == 200
    start_flag = 0
  end
  start_flag = start_flag + 2
end

Window.loop do

  if k % 50 == 0
    1.times do
     enemies << Enemy.new(rand(800), 0, enemy_img)
     enemies2 << Enemy.new(rand(800), 0, enemy_img2)
     enemies3 << Enemy.new(rand(800), 0, enemy_img3)
    end
  end
  Window.draw(0, 200, back)
  Window.draw(0, 0, back)
  
  Window.draw_font(100, 20,"#{score.to_s}" ,font)
  break if Input.keyPush?(K_ESCAPE)

  Sprite.update(enemies)
  Sprite.draw(enemies)

  Sprite.update(enemies2)
  Sprite.draw(enemies2)

  Sprite.update(enemies3)
  Sprite.draw(enemies3)

  player.update
  player.draw

  # 当たり判定
  if Sprite.check(player, enemies)
    score = score + 1
  end

  if Sprite.check(player, enemies2)
    score = score + 1
  end

  if Sprite.check(player, enemies3)
    score = score + 1
  end

  if score > 9
    Window.draw(0, 200, back)
    Window.draw(0, 0, back)
    Window.draw(-20, -20, clear)
    break if Input.keyPush?(K_ESCAPE)
  end

  k = k + 1

end