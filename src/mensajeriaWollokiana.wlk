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
 	method emisor() = usuario
 	
 	method tieneTexto(texto) = contenido.buscar(texto) or usuario.buscarEnNombre(texto)
 	}
 
  //Usuarios
 class Usuario{
 	const property nombre
 	const chats = #{}
 	const notificaciones = new Dictionary() //No se si 
 	var tieneEspacio = true
 	method llenoDeMensajes(){
 		tieneEspacio=false
 	}
 	method tieneEspacio() = tieneEspacio
 	
 	method sumarseAChat(chat) {
 		chat.incorporar(self)
 		chats.add()
 	}
 	method buscarEnNombre(texto) = nombre.contains(texto)
 	//*****************************************************************************//
 	method buscarTextoEnChats(texto) = chats.filter({chat=>chat.buscarTexto(texto)}) // Punto 3
 	//*****************************************************************************//
 	
 	//*****************************************************************************//
	method mensajesMasPesados() = chats.map({chat=>chat.elMasPesado()}) // Punto 4. Paso map porque no quiero modificar la coleccion actual.
 	//*****************************************************************************//
 	method recibirNotificacion(chat, mensaje){
 		notificaciones.put(chat,mensajes.add(mensaje))
 	}
	method sumarNotificacion(chat) = notificaciones.get(chat)+1
	method leerChat(chat){
		notificaciones.put(chat,0)
	}
	method 
 }