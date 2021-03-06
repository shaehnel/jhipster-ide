/*******************************************************************************
 * Copyright (c) 2015 itemis Schweiz GmbH (http://www.itemis.ch) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ch.itemis.xdocker.ui.job

import ch.itemis.xdocker.lib.DockerExtensions
import ch.itemis.xdocker.ui.console.XdockerConsoleLogger
import com.google.inject.Inject
import java.util.Stack
import org.eclipse.core.runtime.IProgressMonitor

import static xdockerdsl.ui.internal.XdockerdslActivator.*
import static ch.itemis.xdocker.ui.preference.XdockerDockerPreferences.*
import static org.eclipse.core.runtime.IStatus.*
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import java.util.Arrays

/**
 * Xdocker Remove Container Job
 * 
 * @author Serano Colameo - Initial contribution and API
 */
class XdockerRemoveCntnrJob extends AbstractXdockerJob {

	static val JOB_NAME = 'Docker Remove Container Job'
	static val ERR_RM_CONTAINER = 'Error removing container from docker'
	static val TASK_RM_CONTAINER = 'Removing container from docker...\n'
	
	@Accessors var List<String> containerIds = newArrayList

	@Inject extension DockerExtensions docker
	@Inject extension XdockerConsoleLogger console = XdockerConsoleLogger.INSTANCE

	new(String containerId) {
		this(Arrays.asList(containerId))
	}

	new(List<String> containerIds) {
		super(JOB_NAME)
		this.containerIds.addAll(containerIds)
		this.docker = DockerExtensions.newInstance(dockerProperties)
	}

	override runInternal(IProgressMonitor monitor) {
		monitor.taskName = TASK_RM_CONTAINER
		return execute
	}

	private def XdockerJobStatus execute() {
		val result = new Stack<XdockerJobStatus>
		docker [
			try {
				removeContainers(containerIds)
				result.push = XdockerJobStatus.createJobOkStatus
			} catch (Exception ex) {
				result.push = new XdockerJobStatus(ERROR, CH_ITEMIS_XDOCKER_XDOCKER, ERROR, ch.itemis.xdocker.ui.job.XdockerRemoveCntnrJob.ERR_RM_CONTAINER, ex)
				log('''«ch.itemis.xdocker.ui.job.XdockerRemoveCntnrJob.ERR_RM_CONTAINER»''')
				log(ex.message)
			}
		]
		return result.last
	}
}
