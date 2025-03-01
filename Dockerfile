# Use the official Apache HTTP Server image from Docker Hub
FROM httpd:2.4
# Copy your custom HTML file to the default document root of Apache
COPY survey.html /usr/local/apache2/htdocs/
