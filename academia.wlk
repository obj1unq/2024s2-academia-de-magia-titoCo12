/** Reemplazar por la solución del enunciado */

class Academia {

	const muebles = #{} 

	method dondeEstaGuardada(cosa) {
		return muebles.find({m => m.tiene(cosa)})
	}

	method guardar(cosa) {
	 	self.validarGuardar(cosa)
		self.agregarAUnMueble(cosa)
	}

	method validarGuardar(cosa) {
		if (self.mueblesAptos(cosa).isEmpty()) 
			{self.error("no hay mueble apto para este objeto")}
		else if (self.cosaExisteEnAcademia(cosa)) 
			{self.error("esa cosa ya esta en la academia")}
	} 	

	method cosaExisteEnAcademia(cosa) {
		return muebles.any({mueble => mueble.tiene(cosa)})
	}

	method mueblesAptos(cosa) {
		const filtrados = muebles.filter({mueble => mueble.puedeGuardar(cosa)})
		return (filtrados)
	}

	method agregarAUnMueble(cosa) {
		self.mueblesAptos(cosa).any().guardar(cosa)
	}


}

class Cosa {

	const marca
	const volumen 
	const esMagica 
	const esReliquia
	method marca() {return marca}
	method volumen() {return volumen}
	method esMagica() {return esMagica}
	method esReliquia() {return esReliquia}
}

class Mueble {
	
	const property cosasGuardadas = #{}
	method puedeGuardar(cosa)
	
	method guardar(cosa) {
		cosasGuardadas.add(cosa)
	}

	method tiene(cosa) {
		return cosasGuardadas.contains(cosa)
	}
}

class Armario inherits Mueble() {
	
	const limiteCant = null

	override method puedeGuardar(cosa) {
		return (cosasGuardadas.count() < limiteCant)
	}

}

class Gabinete inherits Mueble() {

	override method puedeGuardar(cosa) {
		cosa.esMagica()
	}

}

class Baul inherits Mueble() {

	const volumenMax = 0  

	override method puedeGuardar(cosa) {
		return (self.volumenActual() + cosa.volumen() <= volumenMax)
	}

	method volumenActual() {
		const volumenes = cosasGuardadas.map({cosa => cosa.volumen()})
		return (volumenes.sum())
	}

}
