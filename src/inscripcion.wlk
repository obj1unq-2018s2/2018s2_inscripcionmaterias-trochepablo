/** First Wollok example */
object inscripcion {
	method cantidadAlumnosPorMateria(materia) {
		return materia.cantidadAlumnos()
	}
	method cantidadAlumnosEnEsperaPorMateria(materia) {
		return materia.cantidadEstudiantesEspera()
	}
	method guiaEstudiante(estudiante, carrera){
		var materias = {}
		if (estudiante.alumnosCursaCarrera(carrera)) {
			materias = estudiante.carreras()
					.find{x => x == carrera}
					.map{ m => m.materias() }
					.filter{ i => estudiante.puedeCursarMateria(i) }.asSet()
		}
		return materias
	}
	method materiasInscripto(estudiante) = estudiante.materias() // la logica de llenar esta lista en cuando se agrega o quitar al estudiante de la materia
	method materiasEnEsperaInscripto(estudiante) = estudiante.listaEspera()
	
}
