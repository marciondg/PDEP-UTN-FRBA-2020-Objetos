/*
 * Nombre: Garozzo, Marcio Nicolas David
 * Legajo: 168061-4
 * 
 * Puntos de Entrada:
 * 
 * Punto 1: chat.espacio()
 * Punto 2: mensaje.enviarA(chat)
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
 	//**********************************// Punto 2
 	method enviarA(chat){
 		chat.recibirMensaje(self)
 	}
 	//**********************************//
 	method nombreEmisor() = usuario.nombre()
 	method emisor() = usuario
 	
 	method tieneTexto(texto) = contenido.buscar(texto)
 	}
 //TIPOS DE CONTENIDO
 //Sirven para enviar texto... es el más usado. Su peso es de 1KB por caracter.
 class Texto{
 	const property texto = ""
 	method peso() = 1*texto.size()
 	method buscar(txt) = texto.contains(txt)
 }
 // Su peso depende de la duración del mismo. 1 segundo de audio pesa 1.2 KB.
 class Audio{
 	const duracion
 	method peso()=1.2*duracion
 	method buscar(txt) = false
 }
 //De las imágenes conocemos su alto y ancho, medido en pixeles. 
 //El peso de estos mensajes depende del modo de compresión:
 class Imagen{
 	const alto
 	const ancho
 	const compresion
 	method peso()=compresion.peso(self)
 	method calcularPesoOriginal()=(alto*ancho)*2
 	method buscar(txt) = false
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
 	method buscar(txt) = contacto.buscarEnNombre(txt)
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
 	const participantes = #{}
 	const mensajes = []
 	method recibirMensaje(mensaje){
 		self.restricciones(mensaje)
 		mensajes.add()
 	}
 	method restricciones(mensaje){
 		self.verificarEmisor(mensaje)
 		self.verificarAlmacenamiento() 		
 	}
 	method verificarAlmacenamiento(){
 		if(!self.todosConEspacio())
 			self.error("Hay participantes sin espacio suficiente")
 	}
	method verificarEmisor(mensaje){
		if(!self.emisorEnElChat(mensaje))
			self.error("No se encuentra el emisor del mensaje en el chat")
	}
	method todosConEspacio() = participantes.all({participante=>participante.tieneEspacio()})
	method emisorEnElChat(mensaje) = participantes.find(mensaje.emisor())
	
	//********************************************************************//
	method espacio() = mensajes.sum({mensaje=>mensaje.peso()}) // Punto 1
	//********************************************************************//
	
	method incorporar(participante){
		participantes.add(participante)
	}
	method buscarTexto(texto) = self.textoEnEmisor(texto) || self.textoEnCuerpo(texto) || self.textoEnContactos(texto)
	
	method textoEnEmisor(texto) = self.listarEmisores().contains(texto)
	
	method textoEnCuerpo(texto) = mensajes.filter({mensaje=>mensaje.tieneTexto(texto)})
	
	method listarEmisores() = mensajes.map(mensaje=>mensaje.emisor())
 }
 
 class Premium inherits Chat{
 	const creador
 	const control
 	override method restricciones(mensaje){
 		super(mensaje)
 		control.restriccion(self,mensaje)
 	}
 	method emisorCreador(mensaje)= mensaje.emisor() == creador 	
 	method noSuperaLimite(limite) = mensajes.size()<=limite
 	
 	method verificarPeso(mensaje, pesoMaximo) = mensaje.peso()<pesoMaximo
 }
 
 //Restricciones Adicionales
 object difusion{
 	method restriccion(chat,mensaje) = chat.emisorCreador(mensaje)
 }
 class Restringido{
 	const limiteMensajes
 	method restriccion(chat, mensaje) = chat.noSuperaLimite(limiteMensajes)
 }
 class Ahorro{
 	const pesoMaximo
 	method restriccion(chat, mensaje) = chat.verificarPeso(mensaje, pesoMaximo)
 }
 

 //Usuarios
 class Usuario{
 	const property nombre
 	const chats = #{}
 	var tieneEspacio = true
 	method llenoDeMensajes(){
 		tieneEspacio=false
 	}
 	method tieneEspacio() = tieneEspacio
 	
 	method sumarseAChat(chat) {
 		chat.incorporar(self)
 		chats.add()
 	}
 	method buscarTextoEnChats(texto) = chats.filter({chat=>chat.buscarTexto(texto)})
 	
 	method buscarEnNombre(texto) = nombre.contains(texto)
 }