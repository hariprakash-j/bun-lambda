FROM public.ecr.aws/lambda/provided:al2

# Copy custom runtime bootstrap
COPY ./build/runtime/* ${LAMBDA_RUNTIME_DIR}/

# Copy function code
COPY ./test_src/* ${LAMBDA_TASK_ROOT}/

# Set the CMD to your handler (could also be done as a parameter override outside of the Dockerfile)
CMD [ "index.handler" ]