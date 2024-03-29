{$G+,A+,S-,R-,I-,Q-,Y-,D-,L-,N-,E-}
Uses CRT, GFX, UTILS, PICPAK1;
Const
     man        :Array[1..2] of Pointer=(@Man1, @Man2);
     nPitch     =18;
     pitch      :array[1..18] of String[34]=
                             ('IT''S NEW!컴컴컴컴컴컴컴컴컴컴컴�',
                              'IT''S IMPROVED!컴컴컴컴컴컴컴컴컴',
                              'IT FIGHT''S CAVITIES!컴컴컴컴컴컴',
                              'CUTS THROUGH A SHOE!컴컴컴컴컴컴�',
                              'AS SEEN ON TV!컴컴컴컴컴컴컴컴컴�',
                              'WON''T LEAVE A NASTY STAIN!컴컴컴',
                              'ORDER NOW!컴컴컴컴컴컴컴컴컴컴컴�',
                              'NOW WITH FLOURIDE!컴컴컴컴컴컴컴�',
                              'NOW WITH BRIGHTENERS!컴컴컴컴컴컴',
                              'NO MONEY BACK GUARENTEE!컴컴컴컴�',
                              'WORKS LIKE A MIRACLE!컴컴컴컴컴컴',
                              'SEND NO MONEY NOW!컴컴컴컴컴컴컴�',
                              'ALL THIS FOR A PENNY!컴컴컴컴컴컴',
                              'WOW!컴컴컴컴컴컴컴컴컴컴컴컴컴컴�',
                              'WE MUST BE MAD!컴컴컴컴컴컴컴컴컴',
                              'WHY PAY MORE?컴컴컴컴컴컴컴컴컴컴',
                              'MADE IN TAIWAN!컴컴컴컴컴컴컴컴컴',
                              'TASTES LIKE THE REAL THING!컴컴컴'
                              );
     txt              :String='Yes, you TOO can experience that which MILLIONS have sought after!  HAPPINESS! '+
                              ' Meanwhile, why not check out a BBS you can actually CALL!                               '+
                              'AGNOSTIC FRONT - (2o3)-457-9427        Press any key to order this fabulous product!          ';
     nLocs                   =1;
     Locs                    :Array[1..1] of record x,y:byte; end =
                             ({(x:1; y:1),}(x:2; y:20));
     thresh                  =5;
Type
    tTextScreen =array[1..50, 1..80] of record c,a:byte; end;
Var
   scr      :tTextScreen absolute $B800:0000;
   store    :^tTextScreen;
   ox,oy    :word;
   buf      :^tTextScreen;
   curpitch :byte;
   curman   :byte;
   curx,cury:byte;
   z        :byte;
   curpos   :byte;
   tcount   :byte;
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
Procedure SmearIt;
var y,x,c:word;
    pal  :tPal;
Begin
     getTPal(pal);
     for c:=1 to 80 do
     begin
       delay(5);
       for x:=2 to c do
           for y:=1 to (50) do move(scr[y, x], scr[y, x-1], 2);
       Intense(pal, 80-c);
     end;
End;
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
Procedure PutSt(x,y:byte; s:string);
var c:byte;
Begin
     for c:=1 to length(s) do begin buf^[y,(x+c)-1].c:=byte(s[c]);
                                    buf^[y,(x+c)-1].a:=textattr;
                              end;
End;
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
Procedure InitScroller;
Var x:byte;
Begin
     curpos:=1;
     tcount:=1;
     for x:=1 to 80 do begin buf^[1,x].c:=32; buf^[1,x].a:=$1E; end;
End;
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
Procedure UpdateScroller;
Begin
  if tcount=thresh then
   begin
     move(buf^[1,2], buf^[1,1], 158);
     buf^[1,80].c:=byte(txt[curpos]);
     buf^[1,80].a:=$1E;
     inc(curpos);
     if curpos>length(txt) then curpos:=1;
     tcount:=1;
   end else inc(tcount);
End;
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
Procedure Init;
Begin
   new(buf);
   new(store);
   move(scr, store^, 8000);
   ox:=WhereX; oy:=wherey;
   Set50;
   FillChar(buf^, sizeof(buf), #0);
   Randomize;
   curman:=random(2)+1;
   curpitch:=random(nPitch)+1;
   z       :=random(nLocs)+1;
   curx    :=locs[z].x;
   cury    :=locs[z].y;
   CursorOff;
   TextColor(black);
   Textbackground(white);
   InitScroller;
End;
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
Procedure DeInit;
Begin
     asm mov ax, $3; int $10; end;
     move(store^, scr, 8000);
     gotoxy(ox,oy);
     dispose(store);
     dispose(buf);
     textattr:=8;
     writeln('...yes, all graphics were lifted from After Dark''s Totally Twisted');
     writeln('Screen Saver collection.  Go get it...it''s worth it.');
     textattr:=15; WriteLn('컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�');
     textattr:=5;  WriteLn('AGNOSTIC FRONT - (2o3)-457-9427');
     textattr:=15; WriteLn('컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�');
     textattr:=7;  Write(' '+^H);
End;
{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�}
Begin
     Init;
     repeat
       if random(1000)<=50 then curman:=random(2)+1;
       if random(1000)<=2 then begin
                                curpitch:=random(nPitch)+1;
                                z       :=random(nLocs)+1;
                                curx    :=locs[z].x;
                                cury    :=locs[z].y;
                             end;
       UpdateScroller;
       move(Man[curman]^, buf^[2,1], 8000-160);
       textattr:=$70;
       putst(curx, cury, pitch[curpitch]);
       vsinc;
       move(buf^, scr, 8000);
       delay(5);
     until keypressed;
     readkey;
     SmearIt;
     set50;
     cursoroff;
     move(@Card^, mem[segB800:0], 8000);
     pause;
     fade2black(13);
     DeInit;
End.