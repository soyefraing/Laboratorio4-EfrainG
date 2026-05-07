# AWS + LAMBDA
**By Efrain Gatañuadi Iturri**

Este repositorio alberga la arquitectura de nube y el código backend para un sistema de procesamiento de imágenes basado en eventos, desplegado de forma automatizada con **Terraform**.

---

##  Arquitectura y Tecnologías
La solución se apoya en un stack **Serverless** para garantizar alta disponibilidad y costes optimizados:

* **Procesamiento:** AWS Lambda (Node.js).
* **Interfaz:** Amazon API Gateway (REST).
* **Mensajería:** SQS (con políticas de reintentos y DLQ).
* **Persistencia:** S3 Buckets para almacenamiento de activos.
* **Automatización:** Terraform (Infraestructura como Código).

---

##  Organización del Repositorio

*  `iac/terraform/`: Definiciones de infraestructura, variables y configuraciones de seguridad.
*  `src/`: Lógica central de las funciones Lambda y recursos estáticos.
*  `terraform.tfstate.d/`: Gestión de estados lógicos separados por entorno.

---

##  Estrategia de Entornos
Utilizamos **Workspaces** para separar el ciclo de vida del proyecto sin duplicar código:
1.  **Dev:** Pruebas de integración iniciales.
2.  **QA:** Validación de calidad y flujos de error.
3.  **Prod:** Despliegue final orientado al usuario.

---

##  Guía Rápida de Operación

1. **Inicializar Terraform**
   ```bash
   cd iac/terraform
   terraform init
   ```
2. **Seleccionar el Entorno**
   ```bash
   terraform workspace select dev
   ```
   *Si el workspace no existe, puedes crearlo con `terraform workspace new dev`.*

   ```bash
   terraform workspace select qa
   # o
   terraform workspace select prod
   ```

3. **Revisar el Plan de Ejecución**
   ```bash
   terraform plan
   ```

4. **Aplicar los Cambios**
   ```bash
   terraform apply
   ```

5. **Hacer un POST**
   ```bash
   curl.exe -X POST "<link>" -H "Content-Type: image/jpeg" --data-binary "@..\..\src\assets\foto.jpeg"
   ```
   
## Destruir la Infraestructura

Si deseas eliminar todos los recursos creados en un entorno específico, asegúrate de estar en el workspace correcto y ejecuta:
```bash
terraform destroy
```

---
