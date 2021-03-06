/*
 * generated by Xtext 2.10.0-SNAPSHOT
 */
package ch.itemis.xdocker.formatting2

import ch.itemis.xdocker.services.XdockerGrammarAccess
import ch.itemis.xdocker.xdocker.FromStatement
import ch.itemis.xdocker.xdocker.Statement
import ch.itemis.xdocker.xdocker.Xdocker
import com.google.inject.Inject
import org.eclipse.xtext.formatting2.AbstractFormatter2
import org.eclipse.xtext.formatting2.IFormattableDocument

class XdockerFormatter extends AbstractFormatter2 {
	
	@Inject extension XdockerGrammarAccess

	def dispatch void format(Xdocker xdocker, extension IFormattableDocument document) {
		// TODO: format HiddenRegions around keywords, attributes, cross references, etc. 
		for (Statement statements : xdocker.getStatements()) {
			statements.format;
		}
	}

	def dispatch void format(FromStatement fromStatement, extension IFormattableDocument document) {
		// TODO: format HiddenRegions around keywords, attributes, cross references, etc. 
		fromStatement.getImage.format;
		fromStatement.getQualifier.format;
	}
	
	// TODO: implement for MaintainerStatement, RunStatement, CmdStatement, LabelStatement, ExposeStatement, EnvStatement, AddStatement, CopyStatement, EntrypointStatement, VolumeStatement, UserStatement, WorkdirStatement, OnbuildStatement, TagQualifier, DigestQualifier, KeyValueList, SourcesDestValue, ArgumentArray, ArgumentList, KeyValue
}
