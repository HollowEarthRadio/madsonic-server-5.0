/*
 This file is part of Madsonic.

 Madsonic is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 Madsonic is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License		
 along with Madsonic.  If not, see <http://www.gnu.org/licenses/>.

 Copyright 2013 (C) Madevil
 */
package net.sourceforge.subsonic.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.ParameterizableViewController;

import net.sourceforge.subsonic.domain.UserSettings;
import net.sourceforge.subsonic.dao.UserDao;
import net.sourceforge.subsonic.service.SettingsService;
import net.sourceforge.subsonic.service.SecurityService;

/**
 * Controller for the chat frame.
 *
 * @author Sindre Mehus
 */
public class ChatController extends ParameterizableViewController {

    private SettingsService settingsService;
    private SecurityService securityService;

    @Override
    protected ModelAndView handleRequestInternal(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> map = new HashMap<String, Object>();
        ModelAndView result = super.handleRequestInternal(request, response);

        UserSettings userSettings = settingsService.getUserSettings(securityService.getCurrentUsername(request));
        map.put("showChat", true);
        map.put("user", securityService.getCurrentUser(request));

        result.addObject("model", map);
        return result;
    }

    public void setSettingsService(SettingsService settingsService) {
        this.settingsService = settingsService;
    }

    public void setSecurityService(SecurityService securityService) {
        this.securityService = securityService;
    }
}