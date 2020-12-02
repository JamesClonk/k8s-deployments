```yaml
---
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pvc-my-csi-app
spec:
  accessModes:
  - ReadWriteOnce
  capacity:
    storage: 10Gi
  # claimRef:
  #   apiVersion: v1
  #   kind: PersistentVolumeClaim
  #   name: csi-pvc
  csi:
    driver: csi.hetzner.cloud
    fsType: ext4
    volumeHandle: "8315359" # <--- specifiy existing volume ID here
  storageClassName: hcloud-volumes

---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: csi-pvc
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi
  storageClassName: hcloud-volumes
  volumeName: pvc-my-csi-app

---
kind: Pod
apiVersion: v1
metadata:
  name: my-csi-app
spec:
  containers:
    - name: my-frontend
      image: busybox
      volumeMounts:
      - mountPath: "/data"
        name: my-csi-volume
      command: [ "sleep", "1000000" ]
  volumes:
    - name: my-csi-volume
      persistentVolumeClaim:
        claimName: csi-pvc
```