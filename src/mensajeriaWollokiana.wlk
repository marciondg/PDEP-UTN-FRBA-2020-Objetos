import chats.*
import contenidos.*
/*
 * Nombre: Garozzo, Marcio Nicolas David
 * Legajo: 168061-4
 * 
 * Puntos de Entrada:
 * 
 * Punto 1: chat.espacio()
 * Punto 2: mensaje.enviarA(chat)
 * Punto 3: usuario.buscarTextoEnChats(texto)
 * Punto 4: usuario.mensajesMasPesados()
 * Punto 5a: usuario.recibirNotificacion(chat,mensaje)
 * Punto 5b: usuario.leerChat(chat)
 * Punto 5c: usuario.notificacionesSinLeer
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
 	method emisor() = usuario
 	
 	method tieneTexto(texto) = contenido.buscar(texto) or usuario.buscarEnNombre(texto)
 	}
 
  //Usuarios
 class Usuario{
 	const property nombre
 	const chats = #{}
 	const notificacionesPendientes = []
 	var tieneEspacio = true
 	method llenoDeMensajes(){
 		tieneEspacio=false
 	}
 	method tieneEspacio() = tieneEspacio
 	
 	method sumarseAChat(chat) {
 		chats.add(chat)
 		chat.incorporar(self)
 	}
 	method buscarEnNombre(texto) = nombre.contains(texto)
 	//*****************************************************************************//
 	method buscarTextoEnChats(texto) = chats.filter({chat=>chat.buscarTexto(texto)}) // Punto 3
 	//*****************************************************************************//
 	
 	//*****************************************************************************//
	method mensajesMasPesados() = chats.map({chat=>chat.elMasPesado()}) // Punto 4. Paso map porque no quiero modificar la coleccion actual.
 	//*****************************************************************************//
 	
 	method recibirNotificacion(chat, mensaje){
 		notificacionesPendientes.add(new Notificacion(chatOrigen=chat, mensajeNoti=mensaje))		 
 	}
 	
	method leerChat(chat){
		notificacionesPendientes.removeAllSuchThat({notificacion=>notificacion.chat(chat)}) 
		// Borrar todas las notificaciones que provengan del chat pasado por parametro. Considero que si se leen, se borran.
	}
	method notificacionesSinLeer() = notificacionesPendientes
 }
 
 class Notificacion{
 	const chatOrigen
 	const mensajeNoti
 	
 	method chat()=chatOrigen
 }