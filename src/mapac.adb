package body mapac is
   -- FUNCIONES MAPPING:
   -- Funcion 1:
   procedure cvacio(s: out conjunto) is --O(n)
      e: existencia renames s.e;
   begin
      for k in key loop e(k):= false; end loop;
   end cvacio;

   -- Funcion 2:
   procedure poner(s: in out conjunto; k: in key; x: in item) is
      e: existencia renames s.e;
      c: contenido renames s.c;
   begin
      if e(k) then raise ya_existe; end if ;
      e(k):= true; c(k):= x;
   end poner;

   -- Funcion 3:
   procedure consultar(s: in conjunto; k: in key; x: out item)
   is
      e: existencia renames s.e;
      c: contenido renames s.c;
   begin
      if not e(k) then raise no_existe; end if ;
      x:= c(k);
   end consultar;

   -- Funcion 4:
   procedure borrar(s: in out conjunto; k: in key) is
      e: existencia renames s.e;
   begin
      if not e(k) then raise no_existe; end if ;
      e(k):= false;
   end borrar;

   -- Funcion 5:
   -- Actualiza la x (las apariciones)
   procedure actualiza(s: in out conjunto; k: in key; x: in item)
   is
      e: existencia renames s.e;
      c: contenido renames s.c;
   begin
      if not e(k) then raise no_existe; end if ;
      c(k):= x;
   end actualiza;

   -- FUNCIONES ITERADOR:
   -- Funcion 1:
   procedure primero(s: in conjunto; it : out iterador) is
      e: existencia renames s.e;
      k: key renames it.k;
      valid : boolean renames it.valid;
   begin
      k:= key'first;
      while not e(k) and k < key'last loop k:= key'succ(k); end loop;
      valid:= e(k); -- puede pasar que el conjunto est� vac�o y si sucede el iterador no es v�lido
   end primero;

   -- Funcion 2:
   procedure siguiente(s: in conjunto; it : in out iterador) is
      e : existencia renames s.e;
      k : key renames it.k;
      valid : boolean renames it.valid;
   begin
      if not valid then raise mal_uso; end if ;
      if k < key'last then -- descartamos que no est� sobre el �ltimo elemento
         k:= key'succ(k);
         while not e(k) and k < key'last loop k := key'succ(k); end loop;
         valid:= e(k);
      else valid:= false;
      end if ;
   end siguiente;

   --Funcion 3:
   function es_valido(it: in iterador) return boolean is
   begin
      return it.valid;
   end es_valido;

   --Funcion 4:
   procedure obtener(s: in conjunto; it :in iterador; k: out key; x: out item) is
      c : contenido renames s.c;
      valid : boolean renames it.valid;
   begin
      if not valid then raise mal_uso; end if ;
      k:= it.k;
      x:= c(k);
   end obtener;

end mapac;
