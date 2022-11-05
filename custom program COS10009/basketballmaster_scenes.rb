require 'gosu'


module ZOrder
    BACKGROUND, BALL, RIM, SCORE = *0..3
end

class Ball
    attr_accessor :x, :y, :vel_x, :image, :angle, :type, :a, :b, :c, :explode, :cough, :bruh, :powerup 
    def initialize(image, type)
        @image = Gosu::Image.new(image)
        @type = type
        @x = 0
        @y = rand(0..2000)
        @vel_x = 0
        @angle = 0.0

        @a = 0.001
        @b = rand(-3..0)
        @c = rand(1000..2000)

        @explode = Gosu::Sample.new("media/explosion.mp3")
        @bruh = Gosu::Sample.new("media/shit.mp3")
        @cough = Gosu::Sample.new("media/cough.mp3")
        @powerup = Gosu::Sample.new("smb/smb_powerup.wav")
    end
end

class Rim
    attr_accessor :image, :angle, :x, :y, :window
    def initialize(image, window)
        @image = Gosu::Image.new(image)
        @angle = 0.0
        @x = 1500
        @y = 1000
        @window = window
    end
end

class Explosion
    attr_reader :finished 
    def initialize(window, x, y, type)
        @x = x
        @y = y
        @type = type
        @radius1 = 267/2
        @radius2 = 100
        @images1 = Gosu::Image.load_tiles("game/boom1.jpeg", 267, 267)
        @images2 = Gosu::Image.load_tiles("game/toxic.png", 200, 200)

        @image_index = 0
        @finished = false
    end

    def draw
        if @type == :nuke
            if @image_index < @images1.count
                @images1[@image_index].draw(@x - @radius1, @y - @radius1, 2)
            else
                @finished = true 
            end
            @image_index += 1
        elsif @type == :bio
            if @image_index < @images2.count
                @images2[@image_index].draw(@x - @radius2, @y - @radius2, 2)
            else
                @finished = true 
            end
            @image_index += 1  
        end
    end
end

class BasketballGame < Gosu::Window
    def initialize()
        super 3000, 2000
        self.caption = "Basketball master"
        if @background_image_game == nil
            @background_image_game = Gosu::Image.new('game/court1.jpeg')
        end
        @backgroundend_number = rand(0..3)
        @background_image_end1 = Gosu::Image.new("game/kobe.jpeg", :tileable => true)
        @background_image_end2 = Gosu::Image.new("game/lebron.jpeg", :tileable => true)
        @background_image_end3 = Gosu::Image.new("game/jordan.jpeg", :tileable => true)
        @background_image_end4 = Gosu::Image.new("game/harden.jpeg", :tileable => true)
        @scene = :start 
        @start1 = "SINGLE MODE (Press 1)"
        @start2 = "MULTIPLAYER MODE (Press 2)"
        @start3 = "INSTRUCTION (Press 3)"
        @start4 = "QUIT (Press 4)"
        @start5 = "SETTINGS (Press 5)"
        @startfont = Gosu::Font.new(self, 'Merriweather/Merriweather-Regular.ttf', 50)
        if @start_music == nil
            @start_music = Gosu::Song.new('media/smoke.mp3')
        end
        @start_music.play(true)
    end

    def draw
        case @scene
        when :start
            draw_start
        when :game_single
            draw_game_single
        when :game_multi
           draw_game_multi
        when :instruction
            draw_instruction
        when :setting
            draw_setting_menu
        when :music1
            draw_setting_music1
        when :music2
            draw_setting_music2
        when :setbackground
            draw_setting_background
        when :end1
            draw_single_end
        when :end2
            draw_multi_end
        end
    end

    def draw_start
        @background_image_game.draw(0, 0, ZOrder::BACKGROUND)
        @startfont.draw(@start1,230,560,1,3,3,Gosu::Color::RED)
        @startfont.draw(@start2,230,760,1,3,3,Gosu::Color::YELLOW)
        @startfont.draw(@start3,230,960,1,3,3,Gosu::Color::CYAN)
        @startfont.draw(@start4,230,1160,1,3,3,Gosu::Color::GREEN)
        @startfont.draw(@start5,230,1360,1,3,3,Gosu::Color::FUCHSIA)
    end

    def draw_instruction
        @instruction_image.draw(0,0,ZOrder::BACKGROUND)
    end

    def initialize_instruction
        @instruction_image = Gosu::Image.new('game/instruction.png', :tileable => true)
        @scene = :instruction
    end

    def draw_setting_menu
        @background_image_game.draw(0,0,ZOrder::BACKGROUND)
        @startfont.draw('Customise start music (Press 1)',230,760,1,3,3,Gosu::Color::RED)
        @startfont.draw('Customise game music (Press 2)',230,960,1,3,3,Gosu::Color::YELLOW)   
        @startfont.draw('Customise background image (Press 3)',230,1160,1,3,3,Gosu::Color::CYAN)
        @startfont.draw('Return (Press 4)',230,1360,1,3,3,Gosu::Color::GREEN)
    end

    def initialize_setting_menu
        @scene = :setting
    end

    def draw_setting_music1
        @background_image_game.draw(0,0,ZOrder::BACKGROUND)
        @startfont.draw('Smoke - Chris Heria (Press 1)',230,760,1,3,3,Gosu::Color::RED)
        @startfont.draw('My War - Attack on titan OST (Press 2)',230,960,1,3,3,Gosu::Color::YELLOW)   
        @startfont.draw('Paradise - Jujutsu Kaisen OST (Press 3)',230,1160,1,3,3,Gosu::Color::CYAN)
        @startfont.draw('Return (Press 4)',230,1360,1,3,3,Gosu::Color::GREEN)
    end

    def initialize_setting_music1
        @scene = :music1
    end

    def draw_setting_music2
        @background_image_game.draw(0,0,ZOrder::BACKGROUND)
        @startfont.draw('Take Off - Chris Heria (Press 1)',230,760,1,3,3,Gosu::Color::RED)
        @startfont.draw('Militia - Body Kit (Press 2)',230,960,1,3,3,Gosu::Color::YELLOW)   
        @startfont.draw('Zen - Chris Heria (Press 3)',230,1160,1,3,3,Gosu::Color::CYAN)
        @startfont.draw('Return (Press 4)',230,1360,1,3,3,Gosu::Color::GREEN)
    end
    
    def initialize_setting_music2
        @scene = :music2
    end

    def draw_setting_background
        @background_image_game.draw(0,0,ZOrder::BACKGROUND)
        @startfont.draw('Court 1 (Press 1)',230,760,1,3,3,Gosu::Color::RED)
        @startfont.draw('Court 2 (Press 2)',230,960,1,3,3,Gosu::Color::YELLOW)   
        @startfont.draw('Court 3 (Press 3)',230,1160,1,3,3,Gosu::Color::CYAN)
        @startfont.draw('Return (Press 4)',230,1360,1,3,3,Gosu::Color::GREEN)
    end

    def initialize_setting_background
        @scene = :setbackground
    end

    def draw_game_single
        if @starttime > 0
            @font.draw("Level #{@level}", 500, 10, ZOrder::SCORE, 2.0, 2.0, Gosu::Color::GREEN)
        end
        if @starttime > 6000
            @level = 2
        end
        if @starttime > 12000
            @level = 3
        end
        if @starttime > 18000
            @level = 4
        end
        if @starttime > 24000
            @level = 5
        end
        if @starttime > 30000
            @level = 6
        end
        if @starttime > 36000
            @level = 7
        end
        if @starttime > 42000
            @level = 8
        end
        if @starttime > 48000
            @level = 9
        end
        if @starttime > 54000
            @level = 10
        end
        @background_image_game.draw(0, 0, ZOrder::BACKGROUND)
        draw_line(2500, 0, Gosu::Color::RED, 2500, 2000, Gosu::Color::RED, ZOrder::RIM)
        draw_rim @rim
        @allball.each { |ball| draw_ball ball }
        @font.draw("Score: #{@score}", 10, 10, ZOrder::SCORE, 2.0, 2.0, Gosu::Color::YELLOW)
        if @animation
            @explosion.each do |explosion|
                explosion.draw
            end
        end

        unless @playing
            initialize_single_end
        end
    end

    def draw_game_multi
        if @starttime > 0
            @font.draw("Level #{@level}", 500, 10, ZOrder::SCORE, 2.0, 2.0, Gosu::Color::GREEN)
        end
        if @starttime > 6000
            @level = 2
        end
        if @starttime > 12000
            @level = 3
        end
        if @starttime > 18000
            @level = 4
        end
        if @starttime > 24000
            @level = 5
        end
        if @starttime > 30000
            @level = 6
        end
        if @starttime > 36000
            @level = 7
        end
        if @starttime > 42000
            @level = 8
        end
        if @starttime > 48000
            @level = 9
        end
        if @starttime > 54000
            @level = 10
        end
        @background_image_game.draw(0, 0, ZOrder::BACKGROUND)
        draw_line(2500, 0, Gosu::Color::RED, 2500, 2000, Gosu::Color::RED, ZOrder::RIM)
        draw_rim @rim1
        draw_rim_multi @rim2 
        @allball.each { |ball| draw_ball ball }
        @font.draw("Score 1: #{@score}", 10, 10, ZOrder::SCORE, 2.0, 2.0, Gosu::Color::YELLOW)
        @font.draw("Score 2: #{@score_multi}", 10, 100, ZOrder::SCORE, 2.0, 2.0, Gosu::Color::YELLOW)
        if @animation
            @explosion.each do |explosion|
                explosion.draw
            end
        end

        unless @playing
            initialize_multi_end
        end
        
    end

    def update
        case @scene
        when :game_single
            update_game_single
        when :game_multi
            update_game_multi
        end
    end

    def button_down(id)
        case @scene
        when :start
            button_down_start(id)
        when :instruction
            button_down_instruction(id)
        when :setting
            button_down_setting_menu(id)
        when :music1
            button_down_music1(id)
        when :music2
            button_down_music2(id)
        when :setbackground
            button_down_setbackground(id)
        when :end1
            button_down_end(id)
        when :end2
            button_down_end(id)
        end
    end

    def button_down_start(id)
        case id
        when Gosu::Kb1
            initialize_game_single
        when Gosu::Kb2  
            initialize_game_multi 
        when Gosu::Kb3
            initialize_instruction
        when Gosu::Kb4
            close
        when Gosu::Kb5
            initialize_setting_menu
        end
    end

    def button_down_end(id)
        case id
        when Gosu::KbSpace
            initialize
        when Gosu::KbQ
            close
        end
    end

    def button_down_instruction(id)
        case id
        when Gosu::KbQ
            initialize
        end
    end

    def button_down_setting_menu(id)
        case id
        when Gosu::Kb1
            initialize_setting_music1
        when Gosu::Kb2
            initialize_setting_music2
        when Gosu::Kb3
            initialize_setting_background
        when Gosu::Kb4
            initialize
        end
    end

    def button_down_music1(id)
        case id
        when Gosu::Kb1
            @start_music = Gosu::Song.new('media/smoke.mp3')
        when Gosu::Kb2
            @start_music = Gosu::Song.new('media/mywar(menu).mp3')
        when Gosu::Kb3
            @start_music = Gosu::Song.new('media/paradise(menu).mp3')
        when Gosu::Kb4
            initialize
        end
    end

    def button_down_music2(id)
        case id
        when Gosu::Kb1
            @game_music = Gosu::Song.new('media/takeoff.mp3')
        when Gosu::Kb2
            @game_music = Gosu::Song.new('media/militia(main).mp3')
        when Gosu::Kb3
            @game_music = Gosu::Song.new('media/zen(main).mp3')
        when Gosu::Kb4
            initialize
        end
    end

    def button_down_setbackground(id)
        case id
        when Gosu::Kb1
            @background_image_game = Gosu::Image.new('game/court.jpeg')
        when Gosu::Kb2
            @background_image_game = Gosu::Image.new('game/court1.jpeg')
        when Gosu::Kb3
            @background_image_game = Gosu::Image.new('game/court2.jpeg')
        when Gosu::Kb4
            initialize
        end 
    end
  
    def initialize_game_single
        @starttime = 0
        @score = 0
        if @highestscore == nil
            @highestscore = 0
        end
        @level = 1
        @playing = true
        if @game_music == nil
            @game_music = Gosu::Song.new('media/takeoff.mp3')
        end
        @game_music.play(true)

        @allball = Array.new()

        @count = 0
        @strike = 0
        @strike_extend = 0
        @extension_count = 0
        @is_green_count = 0

        @explosion = Array.new
        @animation = false

        @extension = false
        @is_green = false

        @rim = Rim.new("game/rim.jpeg", self)

        @font = Gosu::Font.new(50)

        @scene = :game_single
    end

    def initialize_game_multi
        @scene = :game_multi

        @starttime = 0
        @score = 0
        @score_multi = 0
        @level = 1
        @playing = true
        if @game_music == nil
            @game_music = Gosu::Song.new('media/takeoff.mp3')
        end
        @game_music.play(true)

        @allball = Array.new()

        @count = 0
        @strike = 0
        @strike_extend = 0
        @extension_count = 0
        @is_green_count = 0

        @strike_multi = 0
        @strike_extend_multi = 0
        @extension_count_multi = 0
        @is_green_count_multi = 0

        @explosion = Array.new
        @animation = false

        @extension = false
        @is_green = false

        @extension_multi = false
        @is_green_multi = false

        @rim1 = Rim.new("game/rim.jpeg", self)
        @rim2 = Rim.new("game/rim5.png", self)

        @font = Gosu::Font.new(50)
    end


    def move ball

        if @starttime > 0
            ball.vel_x = 10
        end
        if @starttime > 6000
            ball.vel_x += 8
        end
        if @starttime > 12000
            ball.vel_x += 8
        end
        if @starttime > 18000
            ball.vel_x += 8
        end
        if @starttime > 24000
            ball.vel_x += 8
        end
        if @starttime > 30000
            ball.vel_x += 8
        end
        if @starttime > 36000
            ball.vel_x += 8
        end
        if @starttime > 42000
            ball.vel_x += 8
        end
        if @starttime > 48000
            ball.vel_x += 8
        end
        if @starttime > 54000
            ball.vel_x += 8
        end
        
        ball.x += ball.vel_x
        ball.y = ball.a*ball.x*ball.x + ball.b*ball.x + ball.c
    end

    def move_up rim
        rim.y -= 10
    end

    def move_down rim
        rim.y += 10
    end

    def move_left rim
        rim.x -= 10
    end

    def move_right rim
        rim.x += 10
    end

    def draw_ball ball
        ball.image.draw(ball.x, ball.y, ZOrder::BALL)
    end

    def draw_rim rim
        if mouse_x > 0 && mouse_x < 3000 && mouse_y > 0 && mouse_y < 2000
            rim.x = mouse_x
            rim.y = mouse_y
        end

        if @extension
            rim.image.draw(rim.x - 250, rim.y - 250, ZOrder::RIM)
        else
            rim.image.draw(rim.x - 95, rim.y - 95, ZOrder::RIM)
        end
    end

    def draw_rim_multi rim
        if @extension_multi
            rim.image.draw(rim.x - 95, rim.y - 95, ZOrder::RIM)
        else
            rim.image.draw(rim.x, rim.y, ZOrder::RIM)
        end
    end

    def generate_ball
        random = rand(1..6)
        case random
            when 1
                Ball.new("game/basketball.jpeg", :basketball)
            when 2
                Ball.new("game/shit.jpeg", :poo)
            when 3
                Ball.new("game/footie.jpeg", :rugby)
            when 4
                Ball.new("game/bomb.jpeg", :bomb)
            when 5
                Ball.new("game/corona.png", :virus)
            when 6
                Ball.new("game/soccer.jpeg", :award)
            end
    end

    def intersect ball
        if @is_green
            @is_green_count += 1
            @rim = Rim.new("game/rim2.png", self)    
        else
            @rim = Rim.new("game/rim.jpeg", self)
        end

        if @is_green_count > 10
            @is_green = false
            @is_green_count = 0
        end   
        
        if @extension
            @extension_count += 1
            intersect_extend ball
        end

        if @extension_count > 1000
            @extension = false
            @extension_count = 0
        end

        if Gosu.distance(mouse_x, mouse_y, ball.x, ball.y) < 95
            @strike += 1
            if @strike == 14
                @is_green = true
                case ball.type
                when :basketball
                    if ball.x > 2500
                        @score += 4
                    else
                        @score += 2
                    end
                when :rugby
                    if ball.x > 2500
                        @score += 2
                    else
                        @score += 1
                    end
                when :poo
                    ball.bruh.play
                    if ball.x > 2500
                        @score -= 4
                    else
                        @score -= 2
                    end 
                when :bomb
                    @explosion.push Explosion.new(self, ball.x, ball.y, :nuke)
                    @animation = true
                    ball.explode.play
                    if ball.x > 2500
                        @score -= 10
                    else
                        @score -= 5
                    end
                    @allball.delete ball
                when :virus
                    @explosion.push Explosion.new(self, ball.x, ball.y, :bio)
                    @animation = true
                    ball.cough.play
                    if ball.x > 2500
                        @score -= 20
                    else
                        @score -= 10
                    end
                    @allball.delete ball
                when :award
                    ball.powerup.play
                    @extension = true
                end 
                @strike = 0 
            end
        end
    end

    def intersect_extend ball
        if @is_green
            @is_green_count += 1
            @rim = Rim.new("game/rim4.jpeg", self)    
        else
            @rim = Rim.new("game/rim3.jpeg", self)
        end

        if Gosu.distance(mouse_x, mouse_y, ball.x, ball.y) < 250
            @strike_extend += 1
            if @strike_extend == 30
                @is_green = true
                case ball.type
                when :basketball
                    if ball.x > 2500
                        @score += 4
                    else
                        @score += 2
                    end
                when :rugby
                    if ball.x > 2500
                        @score += 2
                    else
                        @score += 1
                    end
                when :poo
                    ball.bruh.play
                    if ball.x > 2500
                        @score -= 4
                    else
                        @score -= 2
                    end 
                when :bomb
                    @explosion.push Explosion.new(self, ball.x, ball.y, :nuke)
                    @animation = true
                    ball.explode.play
                    if ball.x > 2500
                        @score -= 10
                    else
                        @score -= 5
                    end
                    @allball.delete ball
                when :virus
                    @explosion.push Explosion.new(self, ball.x, ball.y, :bio)
                    @animation = true
                    ball.cough.play
                    if ball.x > 2500
                        @score -= 20
                    else
                        @score -= 10
                    end
                    @allball.delete ball
                when :award
                    @extension = true
                end 
                @strike_extend = 0 
            end
        end
    end

    def intersect_multi ball
        if @is_green
            @is_green_count += 1
            @rim1 = Rim.new("game/rim2.png", self)    
        else
            @rim1 = Rim.new("game/rim.jpeg", self)
        end

        if @is_green_count > 10
            @is_green = false
            @is_green_count = 0
        end   
        
        if @extension
            @extension_count += 1
            intersect_extend_multi ball
        end

        if @extension_count > 1000
            @extension = false
            @extension_count = 0
        end

        if Gosu.distance(mouse_x, mouse_y, ball.x, ball.y) < 95
            @strike += 1
            if @strike == 14
                @is_green = true
                case ball.type
                when :basketball
                    if ball.x > 2500
                        @score += 4
                    else
                        @score += 2
                    end
                when :rugby
                    if ball.x > 2500
                        @score += 2
                    else
                        @score += 1
                    end
                when :poo
                    ball.bruh.play
                    if ball.x > 2500
                        @score -= 4
                    else
                        @score -= 2
                    end 
                when :bomb
                    @explosion.push Explosion.new(self, ball.x, ball.y, :nuke)
                    @animation = true
                    ball.explode.play
                    if ball.x > 2500
                        @score -= 10
                    else
                        @score -= 5
                    end
                    @allball.delete ball
                when :virus
                    @explosion.push Explosion.new(self, ball.x, ball.y, :bio)
                    @animation = true
                    ball.cough.play
                    if ball.x > 2500
                        @score -= 20
                    else
                        @score -= 10
                    end
                    @allball.delete ball
                when :award
                    ball.powerup.play
                    @extension = true
                end 
                @strike = 0 
            end
        end

        if @is_green_multi
            @is_green_count_multi += 1
            @rim2 = Rim.new("game/rim7.png", self)    
        else
            @rim2 = Rim.new("game/rim5.png", self)
        end

        if @is_green_count_multi > 10
            @is_green_multi = false
            @is_green_count_multi = 0
        end   
        
        if @extension_multi
            @extension_count_multi += 1
            intersect_extend_multi ball
        end

        if @extension_count_multi > 1000
            @extension_multi = false
            @extension_count_multi = 0
        end

        if Gosu.distance(@rim2.x, @rim2.y, ball.x, ball.y) < 95
            @strike_multi += 1
            if @strike_multi == 14
                @is_green_multi = true
                case ball.type
                when :basketball
                    if ball.x > 2500
                        @score_multi += 4
                    else
                        @score_multi += 2
                    end
                when :rugby
                    if ball.x > 2500
                        @score_multi += 2
                    else
                        @score_multi += 1
                    end
                when :poo
                    ball.bruh.play
                    if ball.x > 2500
                        @score_multi -= 4
                    else
                        @score_multi -= 2
                    end 
                when :bomb
                    @explosion.push Explosion.new(self, ball.x, ball.y, :nuke)
                    @animation = true
                    ball.explode.play
                    if ball.x > 2500
                        @score_multi -= 10
                    else
                        @score_multi -= 5
                    end
                    @allball.delete ball
                when :virus
                    @explosion.push Explosion.new(self, ball.x, ball.y, :bio)
                    @animation = true
                    ball.cough.play
                    if ball.x > 2500
                        @score_multi -= 20
                    else
                        @score_multi -= 10
                    end
                    @allball.delete ball
                when :award
                    ball.powerup.play
                    @extension_multi = true
                end 
                @strike_multi = 0 
            end
        end
    end

    def intersect_extend_multi ball
        if @is_green
            @is_green_count += 1
            @rim1 = Rim.new("game/rim4.jpeg", self)    
        else
            @rim1 = Rim.new("game/rim3.jpeg", self)
        end

        if Gosu.distance(mouse_x, mouse_y, ball.x, ball.y) < 250
            @strike_extend += 1
            if @strike_extend == 30
                @is_green = true
                case ball.type
                when :basketball
                    if ball.x > 2500
                        @score += 4
                    else
                        @score += 2
                    end
                when :rugby
                    if ball.x > 2500
                        @score += 2
                    else
                        @score += 1
                    end
                when :poo
                    ball.bruh.play
                    if ball.x > 2500
                        @score -= 4
                    else
                        @score -= 2
                    end 
                when :bomb
                    @explosion.push Explosion.new(self, ball.x, ball.y, :nuke)
                    @animation = true
                    ball.explode.play
                    if ball.x > 2500
                        @score -= 10
                    else
                        @score -= 5
                    end
                    @allball.delete ball
                when :virus
                    @explosion.push Explosion.new(self, ball.x, ball.y, :bio)
                    @animation = true
                    ball.cough.play
                    if ball.x > 2500
                        @score -= 20
                    else
                        @score -= 10
                    end
                    @allball.delete ball
                when :award
                    @extension = true
                end 
                @strike_extend = 0 
            end
        end

        if @is_green_multi
            @is_green_count_multi += 1
            @rim2 = Rim.new("game/rim8.png",self)    
        else
            @rim2 = Rim.new("game/rim6.png",self)
        end

        if Gosu.distance(@rim2.x, @rim2.y, ball.x, ball.y) < 250
            @strike_extend_multi += 1
            if @strike_extend_multi == 30
                @is_green_multi = true
                case ball.type
                when :basketball
                    if ball.x > 2500
                        @score_multi += 4
                    else
                        @score_multi += 2
                    end
                when :rugby
                    if ball.x > 2500
                        @score_multi += 2
                    else
                        @score_multi += 1
                    end
                when :poo
                    ball.bruh.play
                    if ball.x > 2500
                        @score_multi -= 4
                    else
                        @score_multi -= 2
                    end 
                when :bomb
                    @explosion.push Explosion.new(self, ball.x, ball.y, :nuke)
                    @animation = true
                    ball.explode.play
                    if ball.x > 2500
                        @score_multi -= 10
                    else
                        @score_multi -= 5
                    end
                    @allball.delete ball
                when :virus
                    @explosion.push Explosion.new(self, ball.x, ball.y, :bio)
                    @animation = true
                    ball.cough.play
                    if ball.x > 2500
                        @score_multi -= 20
                    else
                        @score_multi -= 10
                    end
                    @allball.delete ball
                when :award
                    @extension_multi = true
                end 
                @strike_extend_multi = 0 
            end
        end
    end


    def remove_ball
        @allball.reject! do |ball|
          if ball.x > 3000 + 2 || ball.y > 2000 || ball.x < 0 
            true
          else
            false
          end
        end
    end

    def needs_cursor?; true; end

    def update_game_single
        if @score > @highestscore 
            @highestscore = @score
        end

        if @playing
            @starttime += 1
            @count += 1
            if @starttime > 0
                if @count % 100 == 0
                    @allball.push(generate_ball)
                end
            end
            if @starttime > 6000
                if @count % 50 == 0
                    @allball.push(generate_ball)
                end
            end
            if @starttime > 12000
                if @count % 25 == 0
                    @allball.push(generate_ball)
                end
            end
            if @starttime > 18000
                if @count % 12.5 == 0
                    @allball.push(generate_ball)
                end
            end
            if @starttime > 24000
                if @count % 6.25 == 0
                    @allball.push(generate_ball)
                end
            end
            if @starttime > 30000
                if @count % 3.125 == 0
                    @allball.push(generate_ball)
                end
            end
            if @starttime > 36000
                if @count % 1.5625 == 0
                    @allball.push(generate_ball)
                end
            end
            if @starttime > 42000
                if @count % 0.78125 == 0
                    @allball.push(generate_ball)
                end 
            end
            @allball.each { |ball| move ball }
            @allball.each { |ball| intersect ball}
            @explosion.dup.each do |explosion|
                @explosion.delete explosion if explosion.finished
            end

            self.remove_ball
            @playing = false if @score < 0
        else
            @starttime = 0 
        end 
    end

    def update_game_multi

        if @playing
            @starttime += 1
            @count += 1

            if @starttime > 0
               if @count % 100 == 0
                   @allball.push(generate_ball)
                end
            end
            if @starttime > 6000
                if @count % 50 == 0
                    @allball.push(generate_ball)
                end
            end
            if @starttime > 12000
                if @count % 25 == 0
                    @allball.push(generate_ball)
                end
            end
            if @starttime > 18000
                if @count % 12.5 == 0
                    @allball.push(generate_ball)
                end
            end
            if @starttime > 24000
                if @count % 6.25 == 0
                    @allball.push(generate_ball)
                end
            end
            if @starttime > 30000
                if @count % 3.125 == 0
                    @allball.push(generate_ball)
                end
            end
            if @starttime > 36000
                if @count % 1.5625 == 0
                    @allball.push(generate_ball)
                end
            end
            if @starttime > 42000
                if @count % 0.78125 == 0
                    @allball.push(generate_ball)
                end 
            end

            @allball.each { |ball| move ball }
            @allball.each {|ball| intersect_multi ball}
            @explosion.dup.each do |explosion|
                @explosion.delete explosion if explosion.finished
            end

            if button_down?(Gosu::KbW)
                move_up @rim2
            end

            if button_down?(Gosu::KbS)
                move_down @rim2
            end
            if button_down?(Gosu::KbA)
                move_left @rim2
            end
            if button_down?(Gosu::KbD)
                move_right @rim2
            end
 

            self.remove_ball
            @playing = false if @score < 0 || @score_multi < 0
        else
            @starttime = 0 
            @count = 0
        end 
    end

    def initialize_single_end
        @font_end = Gosu::Font.new(self, 'Merriweather/Merriweather-Regular.ttf', 50)
        @scene = :end1
    end

    def initialize_multi_end
        @font_end = Gosu::Font.new(self, 'Merriweather/Merriweather-Regular.ttf', 50)
        @scene = :end2
    end

    def draw_single_end
        case @backgroundend_number
        when 0
            @background_image_end1.draw(0, 0, ZOrder::BACKGROUND)
        when 1
            @background_image_end2.draw(0, 0, ZOrder::BACKGROUND)
        when 2
            @background_image_end3.draw(0, 0, ZOrder::BACKGROUND)
        when 3
            @background_image_end4.draw(0, 0, ZOrder::BACKGROUND)
        end
        @font_end.draw("Game Over!", 700, 700, ZOrder::SCORE, 7, 7, Gosu::Color::RED)
        @font_end.draw("Your score: #{@score}", 600, 1000, ZOrder::SCORE, 3, 3, Gosu::Color::RED)
        @font_end.draw("Highest score: #{@highestscore}", 1620, 1000, ZOrder::SCORE, 3, 3, Gosu::Color::RED)
        @font_end.draw("Press [space] to return to main menu, press Q to quit", 500, 1150, ZOrder::SCORE, 2, 2, Gosu::Color::FUCHSIA)
    end

    def draw_multi_end
        case @backgroundend_number
        when 0
            @background_image_end1.draw(0, 0, ZOrder::BACKGROUND)
        when 1
            @background_image_end2.draw(0, 0, ZOrder::BACKGROUND)
        when 2
            @background_image_end3.draw(0, 0, ZOrder::BACKGROUND)
        when 3
            @background_image_end4.draw(0, 0, ZOrder::BACKGROUND)
        end
        @font_end.draw("Game Over!", 700, 700, ZOrder::SCORE, 7, 7, Gosu::Color::RED)
        if @score > @score_multi
            @font_end.draw("Player 1 win with score #{@score}", 750, 1000, ZOrder::SCORE, 3, 3, Gosu::Color::RED)
        else
            @font_end.draw("Player 2 win with score #{@score_multi}", 750, 1000, ZOrder::SCORE, 3, 3, Gosu::Color::RED)
        end
        @font_end.draw("Press [space] to return to main menu, press Q to quit", 500, 1150, ZOrder::SCORE, 2, 2, Gosu::Color::FUCHSIA)
    end

end

BasketballGame.new.show