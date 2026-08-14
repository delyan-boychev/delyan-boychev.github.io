# Delyan Boychev — homepage

Personal research and experience website built with Jekyll for GitHub Pages.
It uses self-hosted **Latin Modern**, the OpenType continuation of LaTeX's
Computer Modern typeface.

## Run locally

Install once with `bundle install`, then choose either workflow:

```sh
./preview.sh
```

This is the normal live-reloading Jekyll preview at **http://127.0.0.1:4000**.
On macOS, the script automatically uses Homebrew Ruby instead of Apple's old
system Ruby, even when `/usr/bin` appears first in the shell's PATH.

Alternatively:

```sh
./preview-static.sh
```

This builds the site once and serves the generated files at
**http://127.0.0.1:8000**. You can also run `bundle exec jekyll build` and point
VS Code Live Server specifically at `_site/`.

Do not point Live Server at the repository root. The root contains Liquid and
SCSS source, while the compiled `main.css` exists in `_site/`; serving the root
causes the stylesheet MIME-type error.

## Updating content (no HTML knowledge needed)

The editable profile content lives in `_data/` as simple YAML files. Changes
rebuild automatically while `jekyll serve` is running; otherwise run
`bundle exec jekyll build`.

| File | What it controls |
| --- | --- |
| `_data/profile.yml` | Name, research introduction, biography, and personal note |
| `_data/education.yml` | Education entries (automatically sorted) |
| `_data/experience.yml` | Work experience / internships (automatically sorted) |
| `_data/publications.yml` | Papers (auto-sorted newest first by `year`) |
| `_data/projects.yml` | Current research and selected projects (automatically sorted) |
| `_data/honors.yml` | Honors & awards (order = file order) |
| `_data/skills.yml` | "Scope of Specialization" list (order = file order) |
| `_data/testing.yml` | Testing / certifications |

Publications are sorted by `year`. Education, experience, and projects are
sorted by `sort_key`: ongoing entries first by newest start date, followed by
completed entries by newest end date. Honors and skills retain their file order.

Use `"END-START"`, with each date written as `YYYY-MM`; use `9999-99` as the
end date for ongoing work. For example:

```yaml
start: "July 2026"                 # text displayed on the page
end: "Present"
sort_key: "9999-99-2026-07"       # value used only for sorting
```

For year-only dates, use month `00`, such as `2025-00`. Dates in `start` and
`end` are displayed exactly as written.

### Add a publication

Open `_data/publications.yml`, copy this block and fill it in:

```yaml
- title: "My Paper Title"
  id: "my-paper"  # unique anchor used by Current Research links
  authors: "A. Person, B. Person, Delyan Boychev"
  year: 2026
  type: "Preprint"
  venue: "arXiv"
  link: "https://arxiv.org/abs/XXXX"
  summary: "One concise sentence explaining the contribution."
  # Optional now; add when artwork is available:
  image: /assets/img/publications/my-paper.jpg
  image_alt: "Description of the paper figure"
  links:
    - label: "Paper"
      url: "https://arxiv.org/abs/XXXX"
    - label: "PDF"
      url: "https://arxiv.org/pdf/XXXX"
```

It appears automatically at the top of Publications, sorted by year. Every
entry renders the same metadata line: `year · type · venue`. Use types such as
`Preprint`, `Conference paper`, or `Workshop paper` and give the canonical
venue separately.

For consistent artwork, use a landscape paper figure when possible (roughly
`3:2` or `16:10`) and always provide `image_alt`. Images are optional: without
one, the standard hand-drawn paper icon occupies the same left slot so every
publication remains aligned.

### Mark an internship as ended

In `_data/experience.yml`, find the entry and change:

```yaml
end: "Present"
```

to:

```yaml
end: "Sep 2026"
sort_key: "2026-09-2026-07"
```

The final six digits remain the role's July 2026 start date.

### Edit About Me

Edit the `about_me` list in `_data/profile.yml`. Each `- >-` list item becomes
one paragraph; wrapped lines inside that item remain part of the same paragraph.

### Add a project

Project entries use the same predictable optional-image interface:

```yaml
- id: "project-name"    # unique anchor for related-project links
  title: "Project name"
  category: "software"  # use "research" for the Current Research column
  subtitle: "Short project type"
  year: 2026             # Selected Projects displays only this year
  start: "2026"
  end: "Present"
  sort_key: "9999-99-2026-00"
  summary: "A concise description of the project and its contribution."
  primary_url: "https://github.com/username/project"
  image: "/assets/img/projects/project.webp"
  image_alt: "Description of the project image"
  image_fit: "cover"  # centered square crop; use "contain" for logos
  links:
    - label: "GitHub"
      url: "https://github.com/username/project"
```

`primary_url` makes the project title and its visual slot clickable. Use `image_url`
instead of `image` only for an intentionally remote asset. Project images use
a centered square crop by default; set `image_fit: "contain"` for a logo or
other artwork that must remain completely visible. Without an image, the same
left slot displays the standard hand-drawn project glyph, keeping every row
aligned.

Project-link icons are automatic: write only `label` and `url`. The labels
`GitHub`, `Docs`, `Paper`, `PDF`, `Dataset`, and `PyPI` have dedicated icons; any other
label receives the standard external-link icon. No SVG or HTML is needed in
the YAML entry.

Experience and Current Research entries can link to any number of publication
or project cards using the same structure:

```yaml
related:
  papers:
    - title: "Short paper name"
      id: "my-paper"       # matches _data/publications.yml
  projects:
    - title: "Project name"
      id: "project-name"   # matches _data/projects.yml
```

Omit either group when it is empty and repeat list items as needed. The template
automatically selects the Paper or Project icon and maps the ID to the correct
section anchor. No URL or icon field is required. Publication and project cards
continue to hold their external links.

### Add a project image (optional)

Put the image in `assets/img/projects/` (a square-ish crop works best) and add
one field to the project in `_data/projects.yml`:

```yaml
image: /assets/img/projects/my-project.webp
image_alt: "Short description of the project image"
```

The image replaces the automatic project glyph without changing the row
alignment. Current Research entries are intentionally kept text-only.

### Change your photo

Replace `assets/img/photo.webp` (a square photo looks best). Keep it at
`1024 × 1024` and update the intrinsic dimensions in `index.html` if needed.

## Deploying to GitHub Pages

The site is published from the GitHub user-site repository
`delyan-boychev/delyan-boychev.github.io` and uses the custom domain
`https://dboychev.com`. The repository contains both required settings:

- `_config.yml`: `url: "https://dboychev.com"`
- `CNAME`: `dboychev.com`

Push changes from this directory with:

```sh
git add .
git commit -m "Update personal homepage"
git push origin main
```

On GitHub, open **Settings → Pages**. Under **Build and deployment**, use
**Deploy from a branch**, select `main` and `/ (root)`, and set the custom
domain to `dboychev.com`. Enable **Enforce HTTPS** after GitHub provisions the
certificate. Deployment status appears in the repository's **Actions** tab.

Optionally add a Bing site-verification code to `_config.yml`; the matching
meta tag is already present.

## Notes

- **No phone number, date of birth, or street address** are used anywhere on the site.
- SEO: JSON-LD structured data (Person + ScholarlyArticle), canonical URLs,
  `sitemap.xml` (auto-generated), and `robots.txt` are included.
