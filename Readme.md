Páginas de GitHub Ruby Gem
Una simple joya de Ruby para arrancar dependencias para configurar y mantener un entorno Jekyll local sincronizado con las páginas de GitHub.

Versión de gema Estado de construcción

Uso
Se puede optar por el enfoque convencional de utilizar pages-gem o el enfoque en contenedor en el que se usa un contenedor Docker para proporcionar un entorno con la mayoría de las dependencias preinstaladas.

Convencional
Importante: asegúrese de tener Bundler> v1.14 ejecutándolo gem update bundleren su terminal antes de seguir los siguientes pasos.

Agregue lo siguiente al archivo Gemfile de su proyecto:  
joya  'de GitHub páginas' ,  del grupo : : jekyll_plugins
correr bundle install
Nota: No es necesario que instale Jekyll por separado. Una vez que la github-pagesgema está instalada, puede crear su sitio usando jekyll buildo obtener una vista previa de su sitio usando jekyll serve. Para obtener más información sobre cómo instalar Jekyll localmente, consulte los documentos de ayuda de GitHub al respecto .

Estibador
Siempre que Docker esté instalado, se puede evitar la configuración de herramientas adicionales dentro del entorno simplemente generando un contenedor Docker.

Ejecute make imagedesde la raíz del directorio pages-gem para crear una imagen que se etiquetará comogh-pages
Utilice alternativamente make image_alpinepara una alpineimagen de base más pequeña
Inicie una instancia del servidor ejecutando:
SITE=PATH_TO_YOUR_PROJECT make serverdesde la raíz del gh-pagesrepositorio (donde reside el Makefile) o
SITE=PATH_TO_YOUR_PROJECT docker run --rm -p 4000:4000 -v `realpath ${SITE}`:/src/site gh-pages desde cualquier directorio o
github-pages $PATH_TO_YOUR_PROJECTdesde cualquier directorio cuando func.sh se haya ingresado en su sesión de terminal o
github-pagesdel directorio del sitio de Jekyll para obtener una vista previa cuando func.sh se haya ingresado en su sesión de terminal.
Nota: la github-pagesfunción se puede habilitar mediante el suministro de func.sh. Esto se puede hacer agregando

fuente  $ PATH_TO_THIS_DIRECTORY /contrib/func.sh
a los scripts que se cargan al iniciar una sesión de terminal (generalmente ~/.bashrcen bash o ~/.zshrcen zsh):

La ejecución github-pagesdentro de un directorio de un sitio Jekyll genera un servidor en el puerto 4000 . Se puede proporcionar explícitamente una ruta a un sitio de Jekyll y un puerto ejecutando github-pages $PATH $PORT. Este enfoque se proporciona como una alternativa más fácil de usar a las invocaciones make servero docker runmencionadas como las primeras opciones en el paso 2.

El orden de los argumentos de la github-pagesfunción se basa en la suposición de que es más probable que sea necesario especificar una ruta personalizada en lugar de un puerto personalizado.

Uso de la línea de comandos
La gema Páginas de GitHub también viene con varias herramientas de línea de comandos, contenidas dentro del github-pagescomando.

Lista de versiones de dependencia
$ bundle exec github-pages versiones 
+ --------------------------- + --------- + 
| Gema | Versión | 
+ --------------------------- + --------- + 
| jekyll | xxx | 
| kramdown | xxx | 
| liquido | xxx | 
| .... | .... | 
+ --------------------------- + --------- +
Tenga en cuenta que también puede pasar la --gemfilebandera para obtener las dependencias enumeradas en un formato de dependencia de Gemfile válido. También puede ver una lista de las versiones de dependencia en vivo en pages.github.com/versions .

Chequeo de salud
Comprueba tu sitio de Páginas de GitHub para detectar problemas comunes de configuración de DNS.

$ github-pages health-check 
Comprobando el dominio foo.invalid ... 
Uh oh. Parece que algo huele mal: un registro apunta a una dirección IP obsoleta
Consulte la documentación de Verificación de estado de las páginas de GitHub para obtener más información.

Omitir la lista blanca de complementos
Si desea ejecutar un complemento de Jekyll localmente que no está en la lista blanca para su uso en las páginas de GitHub, puede hacerlo colocando el prefijo jekyll buildo jekyll servecon el comando DISABLE_WHITELIST=true. Esto permitirá que su sitio use cualquier complemento listado en el gemsindicador de configuración de su sitio . Sin embargo, tenga en cuenta que esta opción solo está disponible al obtener una vista previa de su sitio Jekyll localmente.

Actualizando
Para actualizar a la última versión de Jekyll y dependencias asociadas, sólo tiene que ejecutar gem update github-pages, o si ha instalado a través de Bündler, bundle update github-pages.

Objetivos del proyecto
El objetivo de la gema Páginas de GitHub es ayudar a los usuarios de Páginas de GitHub a iniciar y mantener un entorno de compilación de Jekyll que se asemeje más al entorno de compilación de Páginas de GitHub. La gema de Páginas de GitHub se basa en requisitos explícitos compartidos entre las computadoras de los usuarios y los servidores de compilación para garantizar que el resultado de la compilación local de un usuario sea también el resultado de la compilación del servidor.

Las herramientas adicionales, como las herramientas que se integran con la API de GitHub para facilitar la administración de los sitios de las páginas de GitHub, no son el objetivo principal, pero pueden estar dentro del alcance del proyecto.

Que versionado
La gema Páginas de GitHub busca la versión de dos aspectos del entorno de compilación:

1. Ruby
La versión de Ruby con la que se ejecuta Jekyll. Aunque Jekyll en sí mismo puede ser compatible con versiones anteriores o futuras de Ruby, diferentes entornos de ejecución producen resultados diferentes. Ruby 1.8.7 analiza YAML de manera diferente a 1.9.3, por ejemplo, y Kramdown tiene problemas para procesar mailtoenlaces anteriores a 1.9.3. Para garantizar que la compilación local de forma coherente dé como resultado la misma compilación que aparece cuando se publica, es esencial que Ruby se versione junto con la gema, a pesar de que no se conocen incompatibilidades.

2. Dependencias
Esto incluye procesadores Markdown y cualquier otra dependencia de Jekyll para la que la incongruencia de versiones pueda producir resultados inesperados. Tradicionalmente, Maruku, Kramdown, RedCloth, liquid, rdiscount y redcarpet se han mantenido estrictamente debido a cambios importantes conocidos.

Registro de cambios
Ver todos los lanzamientos .

Liberar
Para lanzar una nueva versión de esta gema, ejecute script/releasedesde la masterrama.

Licencia
Distribuido bajo la licencia MIT .
