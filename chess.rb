require_relative"piece.rb"

class TrueClass
  def to_i
    1
  end
end

class FalseClass
  def to_i
    0
  end
end

class Chess  
  attr_accessor  :position,
                 :turn,
                 :white_castling,
                 :black_castling,
                 :line
  def initialize(a,b,c,d,e,f,g,h,i)
    @position=a
    @turn=b
    @white_castling=c
    @black_castling=d
    @line=e
    @wk_pos1=f
    @wk_pos2=g
    @bk_pos1=h
    @bk_pos2=i
  end

  def char_to_line(char)
    char.bytes.to_a[0]-97
  end
  def tr(s, ch)
    res=position[s[2].to_i-1][char_to_line(s[1])]==ch+turn.to_i.to_s &&
    (position[s[5].to_i-1][char_to_line(s[4])]==""|| 
    (position[s[5].to_i-1][char_to_line(s[4])].length==1 && 
    position[s[5].to_i-1][char_to_line(s[4])].to_i==(!turn).to_i)|| 
    position[s[5].to_i-1][char_to_line(s[4])][1]==(!turn).to_i.to_s)
    res
  end
  
def attack(a, b)
  c=!(@turn)
  for i in (a-1)..0
    if position[i][b]=='Л'+c.to_i.to_s ||
       position[i][b]=='Ф'+c.to_i.to_s
       return true
    else if position[i][b]!=""
          break
         end
    end
  end
  for i in (a+1)..7
    if position[i][b]=='Л'+c.to_i.to_s ||
       position[i][b]=='Ф'+c.to_i.to_s
       return true
    else if position[i][b]!=""
          break
         end
    end
  end
  for i in (b-1)..0
    if position[a][i]=='Л'+c.to_i.to_s ||
       position[a][i]=='Ф'+c.to_i.to_s
       return true
    else if position[a][i]!=""
          break
         end
    end
  end
  for i in (b+1)..7
    if position[a][i]=='Л'+c.to_i.to_s ||
       position[a][i]=='Ф'+c.to_i.to_s
       return true
    else if position[a][i]!=""
          break
         end
    end
  end
x=a<b ? a : b
  for i in 1..x
    if position[a-i][b-i]=='С'+c.to_i.to_s ||
       position[a-i][b-i]=='Ф'+c.to_i.to_s
       return true
      else if position[a-i][b-i]!=""
          break
         end
    end
  end
  for i in 1..x
    if position[a-i][b+i]=='С'+c.to_i.to_s ||
       position[a-i][b+i]=='Ф'+c.to_i.to_s
       return true
      else if position[a-i][b+i]!=""
          break
         end
    end
  end
x=(7-a)<(7-b) ? (7-a) : (7-b)
  for i in 1..x
    if position[a+i][b-i]=='С'+c.to_i.to_s ||
       position[a+i][b-i]=='Ф'+c.to_i.to_s
       return true
      else if position[a+i][b+i]!=""
          break
         end
    end
  end
for i in 1..x
    if position[a+i][b+i]=='С'+c.to_i.to_s ||
       position[a+i][b+i]=='Ф'+c.to_i.to_s
       return true
      else if position[a+i][b+i]!=""
          break
         end
    end
  end
  for i in -2..2
    for j in -2..2
      if i.abs+j.abs==3
        if a+i>=0 && a+i<=7 && b+j>=0 && b+j<=7
          if position[a+i][b+j]=='К'+c.to_i.to_s
            return true
          end
        end
      end
    end
  end
  if c && a!=0 && ((b!=0 && position[a-1][b-1]==c.to_i.to_s) ||
     (b!=7 && position[a-1][b+1]==c.to_i.to_s))
      return true
  end
  if !c && a!=0 && ((b!=0 && position[a+1][b-1]==c.to_i.to_s) ||
     (b!=7 && position[a+1][b+1]==c.to_i.to_s))
      return true
  end
  return false
end 

  def move(s)
    if s[0]=='Л'
      k=position[s[5].to_i-1][char_to_line(s[4])]
      if tr(s, 'Л')
        if s[5]==s[2]
          if s[1]<s[4]
            for i in char_to_line(s[1])+1..char_to_line(s[4])-1 do
              if position[s[2].to_i-1][i]!=""
                abort("Невозможный ход")
              end
            end
            position[s[2].to_i-1][char_to_line(s[1])]=""
            position[s[5].to_i-1][char_to_line(s[4])]='Л'+turn.to_i.to_s
            if @turn && attack(@wk_pos1, @wk_pos2) || !@turn && attack(@bk_pos1, @bk_pos2)
              position[s[2].to_i-1][char_to_line(s[1])]='Л'+turn.to_i.to_s
              position[s[5].to_i-1][char_to_line(s[4])]=k
              abort("Невозможный ход")
            end
          else if s[1]!=s[4]
            for i in char_to_line(s[4])+1..char_to_line(s[1])-1 do
              if position[s[2].to_i-1][i]!=""
                abort("Невозможный ход")
              end
            end
            position[s[2].to_i-1][char_to_line(s[1])]=""
            position[s[5].to_i-1][char_to_line(s[4])]='Л'+turn.to_i.to_s
            if @turn && attack(@wk_pos1, @wk_pos2) || !@turn && attack(@bk_pos1, @bk_pos2)
              position[s[2].to_i-1][char_to_line(s[1])]='Л'+turn.to_i.to_s
              position[s[5].to_i-1][char_to_line(s[4])]=k
              abort("Невозможный ход")
            end
            end
          end
        else if s[1]==s[4]
        if s[2]<s[5]
            for i in s[2].to_i..s[5].to_i-2 do
              if position[i][char_to_line(s[1])]!=""
                abort("Невозможный ход")
              end
            end
            position[s[2].to_i-1][char_to_line(s[1])]=""
            position[s[5].to_i-1][char_to_line(s[4])]='Л'+turn.to_i.to_s
          if @turn && attack(@wk_pos1, @wk_pos2) || !@turn && attack(@bk_pos1, @bk_pos2)
              position[s[2].to_i-1][char_to_line(s[1])]='Л'+turn.to_i.to_s
              position[s[5].to_i-1][char_to_line(s[4])]=k
              abort("Невозможный ход")
            end
          else if s[2]!=s[5]
            for i in s[5].to_i..s[2].to_i-2 do
              if position[i][char_to_line(s[1])]!=""
                abort("Невозможный ход")
              end
            end
            position[s[2].to_i-1][char_to_line(s[1])]=""
            position[s[5].to_i-1][char_to_line(s[4])]='Л'+turn.to_i.to_s
           if @turn && attack(@wk_pos1, @wk_pos2) || !@turn && attack(@bk_pos1, @bk_pos2)
              position[s[2].to_i-1][char_to_line(s[1])]='Л'+turn.to_i.to_s
              position[s[5].to_i-1][char_to_line(s[4])]=k
              abort("Невозможный ход")
            end
            end
           end
          else abort("Невозможный ход")
          end
        end
      else abort("Невозможный ход") 
      end
     else if s[0]=='С'
     k=position[s[5].to_i-1][char_to_line(s[4])]
     if tr(s, 'С')
       q=char_to_line(s[1])-char_to_line(s[4])
       if s[2].to_i-s[5].to_i==q || s[5].to_i-s[2].to_i==q
         if s[5]<s[2]
           if s[4]<s[1]
             for i in 1..q-1
               if position[s[2].to_i-i-1][char_to_line(s[1])-i]!=""
                 abort("Невозможный ход")
               end
             end
             position[s[2].to_i-1][char_to_line(s[1])]=""
             position[s[5].to_i-1][char_to_line(s[4])]='С'+turn.to_i.to_s
             if @turn && attack(@wk_pos1, @wk_pos2) || !@turn && attack(@bk_pos1, @bk_pos2)
              position[s[2].to_i-1][char_to_line(s[1])]='С'+turn.to_i.to_s
              position[s[5].to_i-1][char_to_line(s[4])]=k
              abort("Невозможный ход")
             end
           else
             for i in 1..-1*q-1
               if position[s[2].to_i-i-1][char_to_line(s[1])+i]!=""
                 abort("Невозможный ход")
               end
             end
             position[s[2].to_i-1][char_to_line(s[1])]=""
             position[s[5].to_i-1][char_to_line(s[4])]='С'+turn.to_i.to_s
             if @turn && attack(@wk_pos1, @wk_pos2) || !@turn && attack(@bk_pos1, @bk_pos2)
              position[s[2].to_i-1][char_to_line(s[1])]='С'+turn.to_i.to_s
              position[s[5].to_i-1][char_to_line(s[4])]=k
              abort("Невозможный ход")
             end
           end
         else
           if s[4]<s[1]
             for i in 1..q-1
               if position[s[2].to_i+i-1][char_to_line(s[1])-i]!=""
                 abort("Невозможный ход")
               end
             end
             position[s[2].to_i-1][char_to_line(s[1])]=""
             position[s[5].to_i-1][char_to_line(s[4])]='С'+turn.to_i.to_s
             if @turn && attack(@wk_pos1, @wk_pos2) || !@turn && attack(@bk_pos1, @bk_pos2)
              position[s[2].to_i-1][char_to_line(s[1])]='С'+turn.to_i.to_s
              position[s[5].to_i-1][char_to_line(s[4])]=k
              abort("Невозможный ход")
             end
           else
             for i in 1..-1*q-1
               if position[s[2].to_i+i-1][char_to_line(s[1])+i]!=""
                 abort("Невозможный ход")
               end
             end
             position[s[2].to_i-1][char_to_line(s[1])]=""
             position[s[5].to_i-1][char_to_line(s[4])]='С'+turn.to_i.to_s
             if @turn && attack(@wk_pos1, @wk_pos2) || !@turn && attack(@bk_pos1, @bk_pos2)
              position[s[2].to_i-1][char_to_line(s[1])]='С'+turn.to_i.to_s
              position[s[5].to_i-1][char_to_line(s[4])]=k
              abort("Невозможный ход")
             end
           end
         end  
       else abort("Невозможный ход")
       end 
     else abort("Невозможный ход")
     end
     else if s[0]=='Ф'
      k=position[s[5].to_i-1][char_to_line(s[4])]
      if tr(s, 'Ф')
        if s[5]==s[2]
          if s[1]<s[4]
            for i in char_to_line(s[1])+1..char_to_line(s[4])-1 do
              if position[s[2].to_i-1][i]!=""
                abort("Невозможный ход")
              end
            end
            position[s[2].to_i-1][char_to_line(s[1])]=""
            position[s[5].to_i-1][char_to_line(s[4])]='Ф'+turn.to_i.to_s
            if @turn && attack(@wk_pos1, @wk_pos2) || !@turn && attack(@bk_pos1, @bk_pos2)
              position[s[2].to_i-1][char_to_line(s[1])]='Ф'+turn.to_i.to_s
              position[s[5].to_i-1][char_to_line(s[4])]=k
              abort("Невозможный ход")
            end
          else if s[1]!=s[4]
            for i in char_to_line(s[4])+1..char_to_line(s[1])-1 do
              if position[s[2].to_i-1][i]!=""
                abort("Невозможный ход")
              end
            end
            position[s[2].to_i-1][char_to_line(s[1])]=""
            position[s[5].to_i-1][char_to_line(s[4])]='Ф'+turn.to_i.to_s
            if @turn && attack(@wk_pos1, @wk_pos2) || !@turn && attack(@bk_pos1, @bk_pos2)
              position[s[2].to_i-1][char_to_line(s[1])]='Ф'+turn.to_i.to_s
              position[s[5].to_i-1][char_to_line(s[4])]=k
              abort("Невозможный ход")
            end
            end
          end
        else if s[1]==s[4]
        if s[2]<s[5]
            for i in s[2].to_i..s[5].to_i-2 do
              if position[i][char_to_line(s[1])]!=""
                abort("Невозможный ход")
              end
            end
            position[s[2].to_i-1][char_to_line(s[1])]=""
            position[s[5].to_i-1][char_to_line(s[4])]='Ф'+turn.to_i.to_s
            if @turn && attack(@wk_pos1, @wk_pos2) || !@turn && attack(@bk_pos1, @bk_pos2)
              position[s[2].to_i-1][char_to_line(s[1])]='Ф'+turn.to_i.to_s
              position[s[5].to_i-1][char_to_line(s[4])]=k
              abort("Невозможный ход")
            end
          else if s[2]!=s[5]
            for i in s[5].to_i..s[2].to_i-2 do
              if position[i][char_to_line(s[1])]!=""
                abort("Невозможный ход")
              end
            end
            position[s[2].to_i-1][char_to_line(s[1])]=""
            position[s[5].to_i-1][char_to_line(s[4])]='Ф'+turn.to_i.to_s
            if @turn && attack(@wk_pos1, @wk_pos2) || !@turn && attack(@bk_pos1, @bk_pos2)
              position[s[2].to_i-1][char_to_line(s[1])]='Ф'+turn.to_i.to_s
              position[s[5].to_i-1][char_to_line(s[4])]=k
              abort("Невозможный ход")
            end
            end
           end
          else
           q=char_to_line(s[1])-char_to_line(s[4])
       if s[2].to_i-s[5].to_i==q || s[5].to_i-s[2].to_i==q
         if s[5]<s[2]
           if s[4]<s[1]
             for i in 1..q-1
               if position[s[2].to_i-i-1][char_to_line(s[1])-i]!=""
                 abort("Невозможный ход")
               end
             end
             position[s[2].to_i-1][char_to_line(s[1])]=""
             position[s[5].to_i-1][char_to_line(s[4])]='Ф'+turn.to_i.to_s
             if @turn && attack(@wk_pos1, @wk_pos2) || !@turn && attack(@bk_pos1, @bk_pos2)
              position[s[2].to_i-1][char_to_line(s[1])]='Ф'+turn.to_i.to_s
              position[s[5].to_i-1][char_to_line(s[4])]=k
              abort("Невозможный ход")
             end
           else
             for i in 1..-1*q-1
               if position[s[2].to_i-i-1][char_to_line(s[1])+i]!=""
                 abort("Невозможный ход")
               end
             end
             position[s[2].to_i-1][char_to_line(s[1])]=""
             position[s[5].to_i-1][char_to_line(s[4])]='Ф'+turn.to_i.to_s
             if @turn && attack(@wk_pos1, @wk_pos2) || !@turn && attack(@bk_pos1, @bk_pos2)
              position[s[2].to_i-1][char_to_line(s[1])]='Ф'+turn.to_i.to_s
              position[s[5].to_i-1][char_to_line(s[4])]=k
              abort("Невозможный ход")
             end
           end
         else
           if s[4]<s[1]
             for i in 1..q-1
               if position[s[2].to_i+i-1][char_to_line(s[1])-i]!=""
                 abort("Невозможный ход")
               end
             end
             position[s[2].to_i-1][char_to_line(s[1])]=""
             position[s[5].to_i-1][char_to_line(s[4])]='Ф'+turn.to_i.to_s
             if @turn && attack(@wk_pos1, @wk_pos2) || !@turn && attack(@bk_pos1, @bk_pos2)
              position[s[2].to_i-1][char_to_line(s[1])]='Ф'+turn.to_i.to_s
              position[s[5].to_i-1][char_to_line(s[4])]=k
              abort("Невозможный ход")
             end
           else
             for i in 1..-1*q-1
               if position[s[2].to_i+i-1][char_to_line(s[1])+i]!=""
                 abort("Невозможный ход")
               end
             end
             position[s[2].to_i-1][char_to_line(s[1])]=""
             position[s[5].to_i-1][char_to_line(s[4])]='Ф'+turn.to_i.to_s
             if @turn && attack(@wk_pos1, @wk_pos2) || !@turn && attack(@bk_pos1, @bk_pos2)
              position[s[2].to_i-1][char_to_line(s[1])]='Ф'+turn.to_i.to_s
              position[s[5].to_i-1][char_to_line(s[4])]=k
              abort("Невозможный ход")
             end
           end
         end  
       else abort("Невозможный ход")
       end
          end
        end
      end
     else if s[0]=='К'
       if s[1]=='р'
         k=position[s[6].to_i-1][char_to_line(s[5])]
         if position[s[3].to_i-1][char_to_line(s[2])]=="Кр"+turn.to_i.to_s &&
         (position[s[6].to_i-1][char_to_line(s[5])]==""|| 
         (position[s[6].to_i-1][char_to_line(s[5])].length==1 && 
         position[s[6].to_i-1][char_to_line(s[5])].to_i==(!turn).to_i)|| 
         position[s[6].to_i-1][char_to_line(s[5])][1]==(!turn).to_i.to_s)
           if (char_to_line(s[2])-char_to_line(s[5])).abs<2 &&
             (s[3].to_i-s[6].to_i).abs<2
             position[s[3].to_i-1][char_to_line(s[2])]=""
             position[s[6].to_i-1][char_to_line(s[5])]="Кр"+turn.to_i.to_s
             if @turn && attack(@wk_pos1, @wk_pos2) || !@turn && attack(@bk_pos1, @bk_pos2)
              position[s[2].to_i-1][char_to_line(s[1])]="Кр"+turn.to_i.to_s
              position[s[5].to_i-1][char_to_line(s[4])]=k
              abort("Невозможный ход")
             else
               if @turn
                 @wk_pos1=s[6].to_i-1
                 @wk_pos2=char_to_line(s[5])
               else
                 @bk_pos1=s[6].to_i-1
                 @bk_pos2=char_to_line(s[5])
               end
             end
           else abort("Невозможный ход")
           end
         else abort("Невозможный ход")
         end
       else
         k=position[s[5].to_i-1][char_to_line(s[4])]
         if tr(s, 'К')
           if ((char_to_line(s[1])-char_to_line(s[4])).abs==2 &&
           (s[2].to_i-s[5].to_i).abs==1) ||
           ((char_to_line(s[1])-char_to_line(s[4])).abs==1 &&
           (s[2].to_i-s[5].to_i).abs==2)
             position[s[2].to_i-1][char_to_line(s[1])]=""
             position[s[5].to_i-1][char_to_line(s[4])]='К'+turn.to_i.to_s
             if @turn && attack(@wk_pos1, @wk_pos2) || !@turn && attack(@bk_pos1, @bk_pos2)
              position[s[2].to_i-1][char_to_line(s[1])]='К'+turn.to_i.to_s
              position[s[5].to_i-1][char_to_line(s[4])]=k
              abort("Невозможный ход")
             end
           else abort("Невозможный ход")
           end
         else abort("Невозможный ход")
         end 
       end #к
      else
      k=position[s[4].to_i-1][char_to_line(s[3])]
           if position[s[1].to_i-1][char_to_line(s[0])]==turn.to_i.to_s &&
           (position[s[4].to_i-1][char_to_line(s[3])]==""|| 
           (position[s[4].to_i-1][char_to_line(s[3])].length==1 && 
           position[s[4].to_i-1][char_to_line(s[3])].to_i==(!turn).to_i)|| 
           position[s[4].to_i-1][char_to_line(s[3])][1]==(!turn).to_i.to_s)
             if s[0]==s[3]
               if s[1].to_i+1==s[4].to_i ||
                  (s[1].to_i+2==s[4].to_i && (s[1].to_i==2 || s[1].to_i==7))
                   position[s[1].to_i-1][char_to_line(s[0])]=""
                   position[s[4].to_i-1][char_to_line(s[3])]=turn.to_i.to_s
                   if @turn && attack(@wk_pos1, @wk_pos2) || !@turn && attack(@bk_pos1, @bk_pos2)
                   position[s[2].to_i-1][char_to_line(s[1])]=turn.to_i.to_s
                   position[s[5].to_i-1][char_to_line(s[4])]=k
                   abort("Невозможный ход")
                   end
                else abort("Невозможный ход")
                end
             else
               if (char_to_line(s[0])+1==char_to_line(s[3]) ||
                  char_to_line(s[0])-1==char_to_line(s[3])) &&
                  s[1].to_i+1==s[4].to_i
                   position[s[1].to_i-1][char_to_line(s[0])]=""
                   position[s[4].to_i-1][char_to_line(s[3])]=turn.to_i.to_s
                   if @turn && attack(@wk_pos1, @wk_pos2) || !@turn && attack(@bk_pos1, @bk_pos2)
                   position[s[2].to_i-1][char_to_line(s[1])]=turn.to_i.to_s
                   position[s[5].to_i-1][char_to_line(s[4])]=k
                   abort("Невозможный ход")
                   end
                else abort("Невозможный ход")
                end
             end
           else abort("Невозможный ход")
           end
      end #кр
     end #ф
    end #с
   end #л
  @turn=!@turn
  end #фу
end #кл

puts("hg")
a=[["Л1","К1","С1","Ф1","Кр1","С1","К1","Л1"],
   ["1","1","1","1","1","1","1","1"],
   ["","","","","","","",""],
   ["","","С0","","","","",""],
   ["","","","","","","",""],
   ["","","","","","","",""],
   ["0","0","0","0","","0","0","0"],
   ["Л0","К0","С0","Ф0","Кр0","С0","К0","Л0"]]
b=true
c=true
d=true
e=-1
game=Chess.new(a,b,c,d,e,0,4,7,4)
#s=gets.encode("UTF-8").chomp)
#ruby chess.rb
game.move("b2-b3")
puts(a[1][1])
puts(a[2][1])
puts(a[3][2])
puts(game.attack(4, 0))