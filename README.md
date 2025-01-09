# trust_txt_generator
WordPress plugin to generate a website's trust.txt file

1. Explanation of the Code:

    1. Fetch the website's HTML:
        The HTML is parsed to extract the DOM and all of its links.

    2. The existing ecosystem is extracted via code converted from the most recent webcrawl
       
    3. The HTML, extracted links, and ecosystem are used to generate a JSON encoded trust.txt file (an array of strings, one trust.txt file line per array entry)

    4. Return the resulting JSON encoded trust.txt file.
        

2. Make the Plugin Available in WordPress:
   
    Activate the Plugin

      Go to your WordPress Admin Dashboard.
      Navigate to "Plugins" -> "Installed Plugins".
      Click on "Add New Plugin".
      Click on "Upload Plugin".
      Find your "Trust.txt REST API generator" plugin and click "Install Now".
    C  lick on "Activate Plugin"

4. How to Use the REST Web Service

  Once the plugin is activated, you can now make POST requests to the REST endpoint. Here’s how to interact with it:

  Endpoint:

    POST https://your-wordpress-site.com/wp-json/trust-txt/v1/generate

  Request Format:

  Send a POST request with the following JSON body:

    {
      "url": "https://example.com"
    }

  Example Request Using cURL:

    curl -X POST https://your-wordpress-site.com/wp-json/trust-txt/v1/generate -H "Content-Type: application/json" -d '{"url": "https://example.com"}'
