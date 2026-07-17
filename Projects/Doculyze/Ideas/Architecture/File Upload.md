I used a Pre-signed URL-based approach to upload files onto Firebase Cloud Storage.



Validate file type and size -> Create Presigned URL based on filename extension (*skill.MD* -> text/markdown) -> Upload file through Presigned URL to Firebase Cloud Storage using `PUT` request -> Verify file size in Storage:
	* **If true,** mint file in Firestore with status: "uploaded"
	* **If false,** mint file in Firestore with status: "failed"

- (b) Event-driven. A GCS object-finalize notification (Pub/Sub → handler) writes the record, so the server observes every PUT. More infra — and note it would also relocate your Q2 enqueue point from finalizeUpload to the GCS event.

# Code
```typescript
const handleSubmit = async (event: React.FormEvent<HTMLFormElement>): Promise<void> => {

        event.preventDefault();

        const form = event.currentTarget as HTMLFormElement;

        const formData = new FormData(form);

        const title = formData.get('title') as string | null;

  

        if(!fileObj.file) {

            toast.error("No file selected");

            setFileObj(prev => ({ ...prev, uploading: false }));

            return;

        }

        const file = fileObj.file;

        setFileObj(prev => ({ ...prev, title }));

        const { url, docId, contentType } = await getPresignedUrl(file.name, title ?? "", file.size);

        try {

        setFileObj(prev => ({ ...prev, uploading: true }));

        await new Promise((resolve, reject) => {

            const xhr = new XMLHttpRequest();

            xhr.upload.onprogress = (event) => {

                if(event.lengthComputable) {

                    const percentageCompleted = (event.loaded / event.total) * 100;

                    setFileObj(prev => ({ ...prev, progress: Math.round(percentageCompleted) }));

                }

            }

            xhr.onload = async () => {

                if(xhr.status >= 200 && xhr.status < 300) {

                    // Bytes landed — now write the Firestore record (record-after-upload).

                    try {

                        await finalizeUpload(docId, file.name, file.size, title ?? "");

                    } catch (err) {

                        setFileObj(prev => ({ ...prev, uploading: false }));

                        toast.error(`Upload saved but finalize failed: ${err instanceof Error ? err.message : 'Unknown error'}`);

                        reject(err);

                        return;

                    }

                    toast.success("Upload successful!");

                    form.reset();

                    resolve("success");

                } else {

                    setFileObj(prev => ({ ...prev, progress: 0, uploading: false }));

                    toast.error(`Upload failed with status: ${xhr.status}`);

                    reject(new Error(`Upload failed with status: ${xhr.status}`));

                }

            }

            xhr.onerror = () => {

                toast.error(`Upload failed due to a network error`);

                reject(new Error(`Upload failed due to a network error`));

            }

            xhr.open('PUT', url);

            // Echo the SERVER-resolved content-type (Policy B), not file.type — it must match

            // the value pinned into the signed URL or GCS 403s the PUT.

            xhr.setRequestHeader('Content-Type', contentType);

            xhr.setRequestHeader('x-goog-content-length-range', `${MIN_FILE_SIZE},${MAX_FILE_SIZE}`);

            xhr.send(file);

        })

        } catch (error) {

            setFileObj(prev => ({ ...prev, progress: 0, uploading: false }));

            toast.error(`Upload failed: ${error instanceof Error ? error.message : 'Unknown error'}`);

        }

           //  return "success"

    }
```

## TODO
Implement a sweep function that deletes objects in Storage with a *failed* flag in Firestore.

