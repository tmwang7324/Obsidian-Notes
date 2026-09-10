# Form Actions
## UseActionState / UseFormState
A Next.js React hook that creates a variable that records form data state, and a variable that contains a form action. This form action must return the same type as the former data state variable and must have parameters previous form state and formData.

**Server-side**
```typescript
"use server";

type FormState = {
	message: string;
	errors: Record | undefined;
	formFields = {
		email: string,
		password: string	
	};
};

export async function formAction(prevState: FormState, formData: FormData) {
	// do some cool stuff like server-side validation
}
```

**Client-side**
```typescript
import 
export default function LoginForm() {
	const [formState, formAct] = useActionState(formAction, {
	message: '',
	error: undefined,
	formFields: {
		email: '',
		password: '',
	}
	});
	
	return (
		<form action = {formAct}></form>
	) 
}
```

Now, I can call *formState* to get the current user's inputs in the form as well as see if the user input passed all the validation checks by viewing the *message* field inside *formState*.

## useFormStatus()
> A Next.js react hook that returns a status object containing properties like `pending`, `data`, `method`, and `action`. 

**IMPORTANT:** It must be called on a child component of a `form` element.

> I primarily used this hook to retrieve the `pending` status so that I can disable my submit button while the account is logged into or created.

