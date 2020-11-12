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
 	var peso
 	const contenido
 	method peso(){
 		peso = 5+contenido.peso()*1.3
 	}
 }
 //TIPOS DE CONTENIDO
 class Texto{
 	const caracteres
 	method peso() = 1*caracteres
 }
 class Audio{
 	const duracion
 	method peso()=1.2*duracion
 }
 class Imagen{
 	const alto
 	const ancho
 	const compresion
 	method peso()=compresion.peso(self)
 	
 	method calcularPesoOriginal()=alto+ancho
 }
 //Compresiones
 object original{
 	method peso(imagen)=imagen.calcularPesoOriginal()
 }