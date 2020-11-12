/*
 * Nombre: Garozzo, Marcio Nicolas David
 * Legajo: 168061-4
 * 
 * Puntos de Entrada:
 * 
 * Punto 1:
 * Punto 2: 
 * Punto 3: 
 * Punto 4: 
 * Punto 5a: 
 * Punto 5b: 
 * Punto 5c:  
 */
 
 class Mensaje{
 	const usuario
 	const contenido
 	method peso()=5+contenido.peso()*1.3
 	method enviarA(chat){
 		chat.recibirMensaje(self)
 	}
 	}
 //TIPOS DE CONTENIDO
 //Sirven para enviar texto... es el más usado. Su peso es de 1KB por caracter.
 class Texto{
 	const caracteres
 	method peso() = 1*caracteres
 }
 // Su peso depende de la duración del mismo. 1 segundo de audio pesa 1.2 KB.
 class Audio{
 	const duracion
 	method peso()=1.2*duracion
 }
 //De las imágenes conocemos su alto y ancho, medido en pixeles. 
 //El peso de estos mensajes depende del modo de compresión:
 class Imagen{
 	const alto
 	const ancho
 	const compresion
 	method peso()=compresion.peso(self)
 	
 	method calcularPesoOriginal()=(alto+ancho)*2
 }
 
 //Gifs:  son como cualquier imagen pero además se conoce la cantidad de cuadros que tiene.
// El peso de estas imágenes es como una imagen normal de las mismas características multiplicada 
//por la cantidad de cuadros del GIF. En todos los casos se considera que un pixel pesa 2KB.
 
 class Gif inherits Imagen{
 	const cuadros
 	override method calcularPesoOriginal()=super()*cuadros
 }
 
 class Contacto{
 	const contacto
 	method peso()=3
 }
 
 //Compresiones
 
 //Compresión original: no tiene compresión, se envían todos los pixeles.
 object original{
 	method peso(imagen)=imagen.calcularPesoOriginal()
 }
 
 //Variable: Se elige un porcentaje de compresión distinto para cada imagen que determina  
 //la cantidad de pixeles del mensaje original que se van a enviar.
 
 class Variable{
 	const porcentaje
 	method peso(imagen)=imagen.calcularPesoOriginal()-imagen.calcularPesoOriginal()*porcentaje/100
 }
 
 //Maxima: Se envía hasta un máximo de 10.000 píxeles. 
 //Si la imagen ocupa menos que eso se envían todos, sino se reduce hasta dicho máximo.
 object maxima{
 	method peso(imagen)=10000.min(imagen.calcularPesoOriginal())
 }
 
 
 //Chats
 class Chat{
 	const participantes = []
 	method recibirMensaje(mensaje){
 		
 	}
 	method verificarAlmacenamiento(){
 		if(!self.todosConEspacio())
 			self.error("Hay participantes sin espacio suficiente")
 	}
	method todosConEspacio() = participantes.all({participante=>participante.tieneEspacio()})
	
 }
 
 
 //Usuarios
 class Usuario{
 	const nombre
 	var tieneEspacio = true
 	method llenoDeMensajes(){
 		tieneEspacio=false
 	}
 	method tieneEspacio() = tieneEspacio
 }