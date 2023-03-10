 % / /   J u s t   c h a n g e   t h e   c o - o r d i n a t e   a n d   c o n n e c t i v i t y   a n d   p r o p e r t i e s   o f   M a t e r i a l s  
 c l o s e   a l l ;   c l e a r   a l l ;  
 c l c ;  
 f o r m a t   s h o r t ;  
 f o r m a t   c o m p a c t ;  
  
 % - - - - - - - - - - - - - - - - - D a t a   I n p u t   a n d   P r e   P r o c e s s i n g  
  
 %   U n i t s :   m m ,   N e w t o n s ,   M P a  
  
 l e n g t h _ u n i t   =   ' [ m ] ' ;   %   F o r   p r i n t i n g   t h e   r e s u l t  
 f o r c e _ u n i t   =   ' [ N ] ' ;  
 s t r e s s _ u n i t   =   ' [ P a ] ' ;  
  
 E   =   2 0 0 E 9 ;   % ( 2 0 0 G P a   f o r   s t e e l )  
 A   =   0 . 0 0 0 5 ;   %   ( b = 5 0 m m ,   d = 1 0 m m )  
  
 %   n o d e s   a n d   c o n n e c t i o n  
 n o d e s   =   [ 0   0 ;   - 1 0   5 . 7 7 3 5 ;   - 1 0   0 ] ;  
 c o n n   =   [ 1   3 ;   1   2 ;   2   3 ] ;  
  
 %   T h e   n o   o f   e l e m e n t s   i n   t h e   m o d e l  
 n e l   =   l e n g t h ( c o n n ) ;  
  
 %   T h e   n o   o f   n o d e s   i n   t h e   m o d e l  
 n n o d e   =   l e n g t h ( n o d e s ) ;  
  
 %   T o t a l   n o   o f   d e g r e e s   o f   f r e e d o m   i n   t h e   m o d e l  
 n d o f =   2 * n n o d e ;  
  
 % A l l o c a t e   s p a c e   f o r   t h e   v e c t o r   o f   e l e m e n t   l e n g t h  
 l e n g t h s   =   z e r o s ( 1 , n e l ) ;  
  
 %   A l l o c a t e   s p a c e   f o r   t h e   v e c t o r   o f   e l e m e n t   i n c l i n a t i o n   a n g l e  
 a n g l e s   =   z e r o s ( 1 , n e l ) ;  
  
 %   A l l o c a t e   m e m o r y   f o r   t h e   s t i f f n e s s   m a t r i x  
 K   =   z e r o s ( n d o f , n d o f ) ;  
  
 %   v e c t o r   a n d   r o t a t i o n   m a t r i x  
 k e l _ s t o r e   =   c e l l ( n e l , 1 ) ;  
 i n d e x _ s t o r e   =   c e l l ( n e l , 1 ) ;  
 r o t _ s t o r e   =   c e l l ( n e l , 1 ) ;  
  
 %   C a l c u l a t e   t h e   l e n g t h   a n d   a n g l e   o f   e a c h   e l e m e n t  
 f o r   i = 1 : n e l  
   n 1   =   c o n n ( i , 1 ) ;  
   n 2   =   c o n n ( i , 2 ) ;  
   x 1   =   n o d e s ( n 1 , 1 ) ;  
   y 1   =   n o d e s ( n 1 , 2 ) ;  
         x 2   =   n o d e s ( n 2 , 1 ) ;  
   y 2   =   n o d e s ( n 2 , 2 ) ;  
   d x   =   x 2 - x 1 ;  
   d y   =   y 2 - y 1 ;  
   a n g l e s ( i )   =   a t a n 2 ( d y , d x ) ;  
   l e n g t h s ( i )   =   s q r t ( d x ^ 2 + d y ^ 2 ) ;  
         a n g l e s D E g ( i ) =   r a d 2 d e g ( a n g l e s ( i ) ) ;  
 e n d  
 %   T o   d i s p l a y   l e n g t h   a n d   a n g l e   o f   t h e   e l e m e n t  
 f o r   i   =   1 : n e l  
   d i s p ( [ ' L e n g t h   o f   t h e   e l e m e n t ' ,   n u m 2 s t r ( i ) ,   ' = ' ,   n u m 2 s t r ( l e n g t h s ( i ) ) ,   l e n g t h _ u n i t ] )  
   d i s p ( [ ' A n g l e   o f   t h e   e l e m e n t ' ,   n u m 2 s t r ( i ) ,   ' = ' ,   n u m 2 s t r ( a n g l e s ( i ) * 1 8 0 / p i ) ,   ' [ d e g r e e s ] ' ] )  
   d i s p ( '   ' )  
 e n d  
 f   =   l o g i c a l ( [ 0   0   1   0   1   1 ] ) ;  
 s   =   n o t ( f ) ;   %   s p e c i f i e d   ( f i x e d )   D O F s  
 D ( s )   =   0 ;   %   w e   s p e c i f y   t h e   d i s p l a c e m e n t s   o f   s   d o f s  
 %   I n d e x   v e c t o r ,   u s e d   f o r   p o p u l a t i n g   l o c a l   s t i f f n e s s   m a t r i x   i n t o   g l o b a l   s t i f f n e s s   m a t r i x  
 %   h e r e   i n     t h e   f o l l o w i n g   p r o g r a m m e   { 1 }   m e a n s   t h e   n o   o f   e l e m e n t   a n d e   t h e   n o   i n   t h e   ' [ ] '   r e p r e s e n t   t h e   D O F s   o f   t h e   e n d   n o d e s   o f   t h e   r e s p e c t e d   e l e m e n t  
 i n d e x _ s t o r e { 1 }   =   [ 5   6   1   2 ] ;  
 i n d e x _ s t o r e { 2 }   =   [ 1   2   3   4 ] ;  
 i n d e x _ s t o r e { 3 }   =   [ 3   4   5   6 ] ;  
  
 %   G l o b a l   s t i f f n e s s   m a t r i x   a s s e m b l y  
  
 f o r   i   =   1 : n e l   %   N o w   f o r   e a c h   e l e m e n t   i n   t u r n  
   i n d   =   i n d e x _ s t o r e { i } ;  
   L   =   l e n g t h s ( i ) ;  
   t h e t a   =   a n g l e s ( i )  
         E l e m e n t N o ( i ) = i  
         a n g l e s D E g ( i ) =   r a d 2 d e g ( t h e t a )  
   S   =   s i n ( t h e t a )  
   C   =   c o s ( t h e t a )  
   %   G e n e r a t e   t h e   e l e m e n t   r o t a t i o n   m a t r i x  
   T   =   [ C ,   S ,   0 ,   0 ;   - S ,   C ,   0 ,   0 ;   0 ,   0 ,   C ,   S ;   0 ,   0 ,   - S ,   C ]  
         % T T T = t r a n s p o s e ( T ) * T  
   T m a t _ s t o r e { i }   =   T ;  
         %   G e n e r a t e   t h e   e l e m e n t   s t i f f n e s s   m a t r i x   i n   t h e   e l e m e n t s   l o c a l   c o o r d i n a t e   s y s t e m  
         %   c o n d i t i o n   f o r   u s i n g   d i f f e r e n t   s e c t i o n a l   p r o p e r t y  
         C 1   =   ( A * E / L ) ;  
         %   R o t a t e   t h e   e l e m e n t ' s   s t i f f n e s s   m a t r i x   t o   g l o b a l   c o o r d i n a t e s \  
         k e l   =   C 1 * [ 1 ,   0 ,   - 1 ,   0 ;   0 ,   0 ,   0 ,   0 ;   - 1 ,   0 ,   1 ,   0 ;   0 ,   0 ,   0 ,   0 ]  
         k e l B t r _ s { i }   =   k e l ;   % B e f r o e   T r a n s f o r m a t i o n  
   k e l _ t r a n s   =   T ' * k e l * T ;   %   E l e m e n t   s t i f f n e s s   m a t r i x   i n   t h e   g l o b a l   c o o r d i n a t e   s y s t e m  
   %   S t o r e   t h e   s t i f f n e s s   m a t r i x   f o r   l a t e r   u s e :  
   k e l A t r _ s { i }   =   k e l _ t r a n s  
   %   A s s e m b l e   s y s t e m   S t i f f n e s s   m a t r i x ( a d d   t h e   e l e m e n t   m a t r i x   i n   t h e   r i g h t   s p o t )  
   K ( i n d , i n d )   =   K ( i n d , i n d )   +   k e l _ t r a n s ;  
  
 e n d  
  
 f p r i n t f ( ' T h e   s t i f f n e s s   m a t r i x   i s   a s   f o l l o w s   \ n ' )  
 d i s p ( K ) ;  
 %   S o l u t i o n   b y   A d d i n g   S t i f f n e s s   i n   D i a g o n a l   t e r m  
 K ( 2 , 2 ) = K ( 2 , 2 ) * 1 0 0 0 0 ;  
 K ( 5 , 5 ) = K ( 5 , 5 ) * 1 0 0 0 0 ;  
 K ( 6 , 6 ) = K ( 6 , 6 ) * 1 0 0 0 0 ;  
  
  
 f o r c e = z e r o s ( 6 , 1 ) ;  
 f o r c e ( 3 , 1 ) = 1 0 ;  
 f o r c e ( 4 , 1 ) = - 2 0 ;  
 U 1 M = K \ f o r c e ;  
  
 U = z e r o s ( 6 , 1 )  
 U ( 1 , 1 ) = U 1 M ( 1 , 1 ) ;  
 U ( 3 , 1 ) = U 1 M ( 3 , 1 ) ;  
 U ( 4 , 1 ) = U 1 M ( 4 , 1 ) ;  
  
 R F 1 M = K * U  
 %   b y   R o w   c o l u m n   e l e m i n a t i o n  
 K C ( 1 , 1 ) = K ( 1 , 1 ) ;  
 K C ( 2 , 1 ) = K ( 3 , 1 ) ;  
 K C ( 3 , 1 ) = K ( 4 , 1 ) ;  
  
 K C ( 1 , 2 ) = K ( 1 , 3 ) ;  
 K C ( 2 , 2 ) = K ( 3 , 3 ) ;  
 K C ( 3 , 2 ) = K ( 4 , 3 ) ;  
  
 K C ( 1 , 3 ) = K ( 1 , 4 ) ;  
 K C ( 2 , 3 ) = K ( 3 , 4 ) ;  
 K C ( 3 , 3 ) = K ( 4 , 4 ) ;  
  
 f r ( 1 , 1 ) = 0 ;  
 f r ( 2 , 1 ) = 1 0 ;  
 f r ( 3 , 1 ) = - 2 0 ;  
 K i n v = i n v ( K C )  
  
 U 2 M = K C \ f r ;  
  
 R F 2 M = K * U  
