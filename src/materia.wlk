import curso.*

class Materia {
	const property curso = new Curso();
	const property materiaslCorrelativas = []
	var property creditosQueOtorga
	var property creditosRequeridos
	var property anioCursada
	var property cupoMaximo
	const property listaEspera = []
	
	
	method materiaPerteneceACorrelativas(materia) = materiaslCorrelativas.any{ x => x == materia }
	method preRrequisito(estudiante) = true
	method agregarEstudianteACurso(estudiante){
		if(estudiante.puedeCursarMateria(self)){
			if(curso.estudiantes().size() < cupoMaximo){
				curso.agregarEstudiante(estudiante)
				estudiante.materias().add(self)
			}
			else{
				listaEspera.add(estudiante)
				estudiante.listaEspera().add(self)
			}
		}		
	}
	method quitarAlumno(estudiante){
		curso.estudiantes().remove(estudiante)
		estudiante.materias().remove(self)
		if(not listaEspera.isEmpty() && curso.estudiantes().size() < cupoMaximo){
				curso.agregarEstudiante(listaEspera.first())
				estudiante.materias().add(listaEspera.first())
				listaEspera.remove(listaEspera.first())
				estudiante.listaEspera().remove(self)
		}
	}
	method cantidadEstudiantes() = curso.estudiantes().size()
	method cantidadEstudiantesEspera() = listaEspera.size()
}

class MateriaCorrelativa inherits Materia{
	override method preRrequisito(estudiante) =
		self.materiaslCorrelativas().all{ x => estudiante.materiaEstaAprobada(x) }
}

class MateriaCreditos inherits Materia{
	override method preRrequisito(estudiante) =
		estudiante.creditos() >= creditosRequeridos
}

class MateriaPorAnio inherits Materia{
	override method preRrequisito(estudiante) =
		estudiante.carreras()
			.map{ x => x.materias() } // get materias por carreras
			.filter{ m => m.anioCursada() == self.anioCursada() - 1} // tengo todas las materias del anio pasado
			.all{ ma => estudiante.materiaEstaAprobada(ma) } 
}