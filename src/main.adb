with Ada.Text_IO;             use Ada.Text_IO;             -- Archivos
with Ada.Integer_Text_IO;     use Ada.Integer_Text_IO;     -- Entrada y salida de valores enteros
with Ada.Characters.Handling; use Ada.Characters.Handling; -- Caracteres
with mapac, darbolbinario, d_priority_queue;

--FALTA ORDENAR LA TABLA

procedure Main is

   -- DECLARACIONES:
   --Caracteres del espacio y caracteres alfabeticos en minusclula
   subtype alfabet is Character range ' '.. 'z';

   --MAPPING:
   --Uso del package mapping
   package d_taula_frequencias is new mapac (key => alfabet ,item => Integer);
   use d_taula_frequencias;

   -- ARBOL BINARIO:
   --Estructura nodo
   type node is record
      caracter : Character ;
      frequencia : integer ;
   end record ;
   --Uso del package arbol binario
   package darbrol is new darbolbinario (elem => node);
   use darbrol;

   --HEAP - COLA DE PRIORIDAD:
   type parbol is access arbol; --Tipo puntero al tipo arbol
   --Funcion major: Compara si un arbol "frecuencia" es major que otro
   function major(a1,a2: in parbol) return boolean is
      item1, item2: node;
   begin
      raiz(a1.all,item1);
      raiz(a1.all,item2);
      return item1.frequencia > item2.frequencia;
   end major;

    --Funcion menor o igual: Compara si un arbol "frecuencia" es menor o igual que otro
   function menor(a1,a2: in parbol) return boolean is
      item1, item2: node;
   begin
      raiz(a1.all,item1);
      raiz(a1.all,item2);
      return item1.frequencia < item2.frequencia or item1.frequencia = item2.frequencia;
   end menor;
   --Uso del package cola de prioridad
   package d_priority_queue_arbol is new d_priority_queue (size => 20, item => parbol, "<" => menor , ">" => major );

   -- FUNCIONES:
   -- ITERADOR
   -- Función recorrido
   -- Recorre el mapping y lo imprime por pantalla
   procedure recorrido(s: in conjunto) is
      k:  alfabet;  -- Key
      x:  Integer;  -- Item: Frecuencia
      it: iterador; -- Iterador
   begin
      primero(s, it);
      while es_valido(it) loop
         obtener(s, it, k, x);
         --Imprimimos por pantalla
         put_line("Letra: " & k & " apariciones: " & x'Img);
         siguiente(s, it);
      end loop;
   end recorrido;

   -- Función isSameAlf
   -- Añade mira si dos tipos 'alfabet' son iguales.
   --function isSameAlf(a: in alfabet; b: in alfabet) return boolean is
   --begin
   --   return a = b;
   --end isSameAlf;

   -- Función actFreqTabla
   -- Añade los caracteres al conjunto si no estan añadidos. Si lo estan,
   -- incrementamos la aparición (@param x)
   procedure actFreqTabla(s: in out conjunto; c: in alfabet) is
      found: boolean;
      it:    iterador;
      k:     alfabet; -- Tipo Abecedario auxilixar
      x:     Integer; -- Apariciones de k
   begin
      primero(s, it); found := false;
      while es_valido(it) and not found loop
         obtener(s, it, k, x);
         --Si son iguales, hemos encontrado
         if (c = k) then found:= true;
         else siguiente(s, it); --Recorrido
         end if ;
      end loop;
      if found then --Si se ha encontrado
         actualiza(s,c,x + 1); -- Actualizamos las frecuencias
      else poner(s,c,1); -- Si no, ponemos el nuevo caracter
      end if ;
   end actFreqTabla;

   -- Función readTex()
   -- Lee caracter a caracter de un fichero y Actualiza la frecuencia de los
   -- caracteres
   procedure readFile(s: in out conjunto) is
      f_entrada: File_Type; --Fichero
      c:         alfabet;   --Caracter tipo alfabetico
   begin
      --Leemos del fichero
      Open(f_entrada,mode => In_File,name => "entrada.txt");
      --Mientras no sea final de fichero
      while not End_Of_File(f_entrada) loop
         get(f_entrada,c);
         actFreqTabla(s,c); --Actualizar frecuencia de los caracteres
      end loop;
      Close(f_entrada);
   end readFile;

   -- Función writeText()
   -- Escribe cada caracter con su frecuencia en un fichero
   procedure writeFile(s: in out conjunto) is
      f_salida: File_Type; --Fichero
      k:  alfabet;  -- Key
      x:  Integer;  -- Item
      it: iterador; -- Iterador
   begin
      --Creamos fichero
      Create(f_salida, mode => Out_File,name => "salida_freq.txt");
      --Recorrido por el conjunto
      primero(s, it);
      while es_valido(it) loop
         obtener(s, it, k, x);
         put_line(f_salida,"Letra: " & k & " apariciones: " & x'Img);
         siguiente(s, it);
      end loop;
      Close(f_salida);
   end writeFile;

   --
   procedure inIt_ArbolBin(s: in out conjunto; arbol: in out arbol) is
      k:  alfabet;  -- Key
      x:  Integer;  -- Item: Frecuencia
      it: iterador; -- Iterador
      nodo: node;   -- Nodo
      auxArbol: parbol;
   begin
      --auxArbol:= new arbol;
      --avacio(auxArbol); --Arbol vacio

      primero(s, it);
      while es_valido(it) loop
         obtener(s, it, k, x);

         nodo.caracter:= k;
         nodo.frequencia:= x;

         --Crear arbol con solo la raiz
         graft(arbol,null,null,nodo);

         --METER EL ARBOL AL HEAP

         siguiente(s, it);
      end loop;
   end inIt_ArbolBin;

   -- VARIABLES:
   s: conjunto;
begin
   cvacio(s);    --InIt Mapping
   readFile(s);  --Leemos el fichero e incorporamos caracteres
   recorrido(s); --Imprimimos por pantalla las frecuencias
   writeFile(s); --Escribimos las frequencias
end Main;
