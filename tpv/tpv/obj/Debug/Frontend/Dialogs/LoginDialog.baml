   M S B A M L   `   `   `  ????>  :tpv, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null;"clr-namespace:tpv.Frontend.Dialogstpv.Frontend.Dialogs  5   	   &     tpv.Frontend.Dialogs.LoginDialog   5      R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   T PMahApps.Metro, Version=2.0.0.0, Culture=neutral, PublicKeyToken=51482d6f650b2b3f6mah,http://metro.mahapps.com/winfx/xaml/controls  5   	   c _MaterialDesignThemes.MahApps, Version=0.2.5.0, Culture=neutral, PublicKeyToken=df2a72020bd7962a_ [MaterialDesignThemes.Wpf, Version=4.6.1.0, Culture=neutral, PublicKeyToken=df2a72020bd7962a=mat1http://materialdesigninxaml.net/winfx/xaml/themes   5   	   0local"clr-namespace:tpv.Frontend.Dialogs   5   	     ? Title$  INICIAR SESIÓN??5
   	   $	??450??6    $	??800??6-    ? WindowState$ 	Maximized=?69   .??5      ? ??5   
   ?? 5       ?? 
StartPoint$	 0,0&?6"    ?? EndPoint$	 1,1&?63   .??5      ?  ? Color$
 #333??6    ? Offset$	 0.5Q?6,   ? 5      $
 #000??6   $	 1.0Q?6,   5      .+?5   
   ? $??Center=?6    ? RowDefinitions 5      ?? 5      $
??Auto ?6    ?? 5      $
??Auto ?6    ?? 5      $
??Auto ?6    ?? 5      $
??Auto ?6    .+?5      ?? $??0??6   $??INICIAR SESIÓN??6%   $??Center=?6;   $??48(?6X   $??0, 30, 0, 50q?6f   
???????6|   ?? 5      $??1??6    ?? Orientation$ 
Horizontal=?6&   $??Center=?6?   $	??260??6\   .+?5      ?? $??10, 0, -35, 0q?6   $??56??60   $??56??6;    K? ZIndex$ 1??6G   	 ?? Padding$	 5q?6X   $??1q?6d   ???#2F9CFA
 ?? CornerRadius$
 30??6?   ._?5      '  !MaterialDesignThemes.Wpf.PackIcon     Kind$ AccountOutline=?6#   $??32??69   $??32??6D   
???????$??Center=?6c   $??Center=?6?   5      ?? 5      $??10, 0, -20, 0q?6   $??40??60   $ 0??6<   $	 5q?6M   $??1q?6Y   $
 0, 25, 25, 0??6m   ??5      ?? 5        ?? Color$ White??6*    ?? Opacity$	 0.3Q?68   ._?5"      ?? -   5         ??Name$ txbUsername??5"     $??admin??6   $	??200??6+   $ 0??67   
???????$??25, 0, 10, 0q?6[   .  (MaterialDesignThemes.Wpf.TextFieldAssist   DecorationVisibility$ Hidden=?6r   $??0q?6?   
?????? )  #MaterialDesignThemes.Wpf.HintAssist   Hint$ Nombre de Usuario??6?   $??Center=?6?   6  5#      5$      ?? 5%      $??2??6   $ 
Horizontal=?6&   $??Center=?6?   $??0, 30, 0, 50q?6\   $	??260??6r   .+?5&      ?? $??10, 0, -35, 0q?6   $??56??60   $??56??6;   $ 1??6G   $	 5q?6X   $??1q?6d   ???#2F9CFA$
 30??6?    ? Cursor$  ??6?   ._?5'        $ LockOutline=?6#   $??32??66   $??32??6A   
???????$??Center=?6`   $??Center=?6}   5(      ?? 5)      $??10, 0, -20, 0q?6   $??40??60   $ 0??6<   $	 5q?6M   $??1q?6Y   $
 0, 25, 25, 0??6m   $  ??6?   ??5*      ?? 5+      $ White??6*   $	 0.3Q?68   ._?5-      G? -   5         G?Name$ pwdPassword??5-      G? Password$ admin??6"   $	??200??63   $ 0??6?   
???????$??25, 0, 10, 0q?6c   $ Hidden=?6z   $??0q?6?   
?????? $ Contraseña??6?   $??Center=?6?   6  5.      5/      ?? 50      -   5         ??Name$ btnLogin??50   ?   $??3??6   $??INICIAR SESIÓN??6"    ?? 	IsDefault . $	??250??6L   
?????? $
??Bold"?6r   $??0, 0, 0, 30q?6?   $??40??6?   +  %MaterialDesignThemes.Wpf.ButtonAssist   CornerRadius$ 20??6?   6?   51      52      53      