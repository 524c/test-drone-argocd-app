# create-svelte

Everything you need to build a Svelte project, powered by [`create-svelte`](https://github.com/sveltejs/kit/tree/master/packages/create-svelte).

## Creating a project

If you're seeing this, you've probably already done this step. Congrats!

```bash
# create a new project in the current directory
npm create svelte@latest

# create a new project in my-app
npm create svelte@latest my-app
```

## Developing

Once you've created a project and installed dependencies with `npm install` (or `pnpm install` or `yarn`), start a development server:

```bash
npm run dev

# or start the server and open the app in a new browser tab
npm run dev -- --open
```

## Building

To create a production version of your app:

```bash
npm run build
```

You can preview the production build with `npm run preview`.

> To deploy your app, you may need to install an [adapter](https://kit.svelte.dev/docs/adapters) for your target environment.

---

## extra build tasks

## TODO: include in kustomize resources

### https://hub.tekton.dev/tekton/task/hadolint

kubectl apply -n stage -f https://api.hub.tekton.dev/v1/resource/tekton/task/kaniko/0.6/raw
kubectl apply -n stage -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/git-clone/0.9/git-clone.yaml
kubectl apply -n stage -f https://api.hub.tekton.dev/v1/resource/tekton/task/gitea-set-status/0.1/raw
kubectl apply -n stage -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/kubernetes-actions/0.2/kubernetes-actions.yaml
kubectl apply -n stage -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/gitea-set-status/0.1/gitea-set-status.yaml
kubectl apply -n stage -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/git-cli/0.4/git-cli.yaml
kubectl apply -n stage -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/hadolint/0.1/hadolint.yaml
kubectl apply -n stage -f https://api.hub.tekton.dev/v1/resource/tekton/task/pull-request/0.1/raw
