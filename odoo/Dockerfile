FROM xcgd/odoo:8.0
MAINTAINER neal.symms@gmail.com

ADD boot.1 /app/bin/boot.1

# Set the default entrypoint (non overridable) to run when starting the container
ENTRYPOINT ["/app/bin/boot.1"]
CMD ["help"]

# Expose the odoo ports (for linked containers)
EXPOSE 8069 8072

