/*
 * This file and its contents are supplied under the terms of the
 * Common Development and Distribution License ("CDDL"), version 1.0.
 * You may only use this file in accordance with the terms of version
 * 1.0 of the CDDL.
 *
 * A full copy of the text of the CDDL should have accompanied this
 * source. A copy of the CDDL is also available via the Internet at
 * http://www.illumos.org/license/CDDL.
 *
 * Copyright 2021 OmniOS Community Edition (OmniOSce) Association.
 */

/*
 * To build, run `make` in this directory.
 *
 * The resulting files can be tested in various ways:
 *
 *	java Test
 *	java -jar Test.jar
 *	./Test.jar		 (which will use the default system java)
 */

import java.io.IOException;
import java.net.URL;
import java.net.URLConnection;
import java.awt.*;
import java.awt.Image;
import java.awt.image.BufferedImage;

public class Test
{
    private static String url = "https://omnios.org/";

    public static void main(String[] args) throws Exception
    {
        String version = System.getProperty("java.version");
        System.out.println("Runtime version: " + version);

        /* Fonts */

        Font defaultFont = Font.decode(null);
        System.out.println(defaultFont);

        GraphicsEnvironment g =
            GraphicsEnvironment.getLocalGraphicsEnvironment();

        String fonts[] = g.getAvailableFontFamilyNames();

        System.out.println("Available fonts:");
        for (int i = 0; i < fonts.length; i++)
                System.out.println("    " + fonts[i]);

        System.out.println("Rendering image");
        BufferedImage img = new BufferedImage(640, 480,
            BufferedImage.TYPE_INT_ARGB);
        img.getGraphics().drawString("omnios.org", 20, 20);

        /* TLS */
        System.out.println("Testing " + Test.url);
        URLConnection conn = new URL(Test.url).openConnection();
        conn.connect();
        System.out.println("Connected.");
    }
}

