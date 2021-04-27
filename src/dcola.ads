   generic

      type elem is private;

   package dcola is

      --Type
      type cola is limited private;

      --Excepciones
      mal_uso: exception;
      espacio_desbordado: exception;

      --Funciones
      procedure cvacia (qu: out cola);
      procedure poner (qu: in out cola; x: in elem);
      procedure borrar_primero(qu: in out cola);
      function coger_primero (qu: in cola) return elem;
      function esta_vacia(qu: in cola) return boolean;
      function is_last_item(qu: in cola) return boolean;
   private

      type nodo;
      type pnodo is access nodo;

      --Record nodo
      type nodo is record
         x: elem;
         sig: pnodo;
      end record;

      --Record cola
      type cola is record
         p, q: pnodo; --q inicio cola (consulta), p final cola (inserción)
      end record;

   end dcola;
