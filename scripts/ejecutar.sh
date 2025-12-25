#!/bin/bash

STACK_NAME="MiSolucionPro"

echo "1. Borrando cualquier intento previo si existe..."
aws cloudformation delete-stack --stack-name $STACK_NAME
echo "Esperando a que se limpie el entorno..."
aws cloudformation wait stack-delete-complete --stack-name $STACK_NAME

echo "2. Validando la plantilla..."
aws cloudformation validate-template --template-body file://plantilla.yaml

echo "3. Creando la infraestructura..."
aws cloudformation create-stack --stack-name $STACK_NAME --template-body file://plantilla.yaml

echo "4. Esperando a que termine (esto toma 2 min)..."
aws cloudformation wait stack-create-complete --stack-name $STACK_NAME

echo "¡LISTO! Infraestructura creada correctamente."
aws cloudformation describe-stacks --stack-name $STACK_NAME --query "Stacks[0].StackStatus"