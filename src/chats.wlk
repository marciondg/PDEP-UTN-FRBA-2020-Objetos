import mensajeriaWollokiana.*
import contenidos.*
 //Chats
 class Chat{
 	const participantes = #{}
 	const mensajes = []
 	method recibirMensaje(mensaje){
 		self.restricciones(mensaje)
 		mensajes.add(mensaje)
 		self.enviarNotificaciones(mensaje)
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
	method emisorEnElChat(mensaje) = participantes.contains(mensaje.emisor())
	
	//********************************************************************//
	method espacio() = mensajes.sum({mensaje=>mensaje.peso()}) // Punto 1
	//********************************************************************//
	
	method incorporar(participante){
		if(participantes.contains(participante))
			self.error("El usuario ya se encuentra")
		else
			participantes.add(participante)
	}
	method buscarTexto(texto) = mensajes.any({mensaje=>mensaje.tieneTexto(texto)})
 
 	method elMasPesado() = mensajes.max({mensaje=>mensaje.peso()})
	method enviarNotificaciones(mensaje) {
	participantes.forEach({participante=>participante.recibirNotificacion(self,mensaje)})
}
 
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
 
