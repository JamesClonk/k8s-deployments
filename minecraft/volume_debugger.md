kind: Pod
apiVersion: v1
metadata:
  name: volume-debugger
  namespace: minecraft
spec:
  securityContext:
    runAsUser: 1000
    runAsGroup: 2000
    fsGroup: 2000
  volumes:
  - name: volume-to-debug
    persistentVolumeClaim:
     claimName: minecraft
  containers:
  - name: debugger
    image: busybox
    command: ['sleep', '3600']
    volumeMounts:
    - mountPath: "/data"
      name: volume-to-debug
