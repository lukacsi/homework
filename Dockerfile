FROM gcc:10 as builder
WORKDIR /build
COPY main.cpp .
RUN g++ main.cpp -o server

FROM debian:buster-slim
WORKDIR /hello-world
COPY --from=builder /build/server .
EXPOSE 80
CMD ["./server"]

