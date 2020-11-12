import mensajeriaWollokiana.*
import chats.*

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
