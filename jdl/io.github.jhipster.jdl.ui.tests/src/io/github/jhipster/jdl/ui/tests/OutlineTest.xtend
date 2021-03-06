package io.github.jhipster.jdl.ui.tests

import org.eclipse.xtext.junit4.InjectWith
import org.eclipse.xtext.junit4.XtextRunner
import org.eclipse.xtext.junit4.ui.AbstractOutlineTest
import org.junit.Test
import org.junit.runner.RunWith
import io.github.jhipster.jdl.ui.internal.JdlActivator

@RunWith(typeof(XtextRunner))
@InjectWith(typeof(JDLUiInjectorProvider))
class OutlineTest extends AbstractOutlineTest {

	override protected getEditorId() {
		JdlActivator.IO_GITHUB_JHIPSTER_JDL_JDL
	}

	@Test def void testOutline() {
		'''
			entity Address {
			  street String required,
			  streetNr Integer required
			}
			
			entity Person {
			  firstName String required,
			  lastName String required
			}

			relationship OneToMany {
			  Address to Person
			}
			
			dto * with mapstruct except A
		'''.assertAllLabels(
			'''
				Address
				  street
				  streetNr
				Person
				  firstName
				  lastName
				OneToMany
				  Address - Person
				Option: DTO
				User
			'''
		)
	}
}
