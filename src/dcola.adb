
   package body dcola is

      --cola vacia
      procedure cvacia(qu: out cola) is
         p: pnodo renames qu.p;
         q: pnodo renames qu.q;
      begin
         p:= null; q:= null;
      end cvacia;

      --Ver si la cola esta vacia
      function esta_vacia(qu: in cola) return boolean is
         q: pnodo renames qu.q;
      begin
         return q=null;
      end esta_vacia;


      --Coge el primero de la cola
      function coger_primero(qu: in cola) return elem is
         q: pnodo renames qu.q;
      begin
         return q.x;
      exception
         when constraint_error => raise mal_uso;
      end coger_primero;

      --Poner elemento en la cola
      procedure poner(qu: in out cola; x: in elem)
      is
         p: pnodo renames qu.p;
         q: pnodo renames qu.q;
         r: pnodo;
      begin
         r:= new nodo;
         r.all:= (x, null);
         if p=null then -- la cola esta vacia
            p:= r; q:= r;
         else
            p.sig:= r; p:= r;
         end if ;
      exception
         when storage_error => raise
              espacio_desbordado;
      end poner;

      --Borrar el primer elemento de la cola
      procedure borrar_primero(qu: in out cola) is
         p: pnodo renames qu.p;
         q: pnodo renames qu.q;
      begin
         q:= q.sig;
         if q=null then p:= null; end if ;
      exception
         when constraint_error => raise mal_uso;
      end borrar_primero;

      --Ver si es el último item
   function is_last_item(qu: in cola) return boolean is
      p: pnodo renames qu.p;
      q: pnodo renames qu.q;
   begin
      if p.x = q.x then
         return true;
      else
         return false;
      end if;
   end is_last_item;


   end dcola;
