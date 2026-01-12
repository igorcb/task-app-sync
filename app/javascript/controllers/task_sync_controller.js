import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["userName", "company", "city", "syncButton", "buttonText", "buttonIcon", "message", "messageText", "userIdInput"]
  static values = { url: String }

  async syncUser(event) {
    event.preventDefault()

    const userId = this.userIdInputTarget.value || 1

    if (userId < 1 || userId > 10) {
      this.showMessage("Por favor, digite um ID entre 1 e 10", "error")
      return
    }

    this.syncButtonTarget.disabled = true
    this.buttonTextTarget.textContent = "Sincronizando..."
    this.buttonIconTarget.classList.add("animate-spin")
    this.hideMessage()

    try {
      const response = await fetch(this.urlValue, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": this.getCSRFToken()
        },
        body: JSON.stringify({ user_id: userId })
      })

      const data = await response.json()

      if (response.ok) {
        this.updateTaskData(data.task)
        this.showMessage("Dados sincronizados com sucesso!", "success")
      } else {
        this.showMessage(data.error || "Erro ao sincronizar dados", "error")
      }
    } catch (error) {
      this.showMessage("Erro de conexão ao sincronizar", "error")
      console.error("Sync error:", error)
    } finally {
      this.syncButtonTarget.disabled = false
      this.buttonTextTarget.textContent = "Sincronizar usuário"
      this.buttonIconTarget.classList.remove("animate-spin")
    }
  }

  updateTaskData(task) {
    this.userNameTarget.textContent = task.external_user_name
    this.companyTarget.textContent = task.external_company
    this.cityTarget.textContent = task.external_city
  }

  showMessage(text, type) {
    const messageDiv = this.messageTarget
    const messageText = this.messageTextTarget

    messageDiv.style.display = "block"
    messageText.textContent = text

    messageDiv.classList.remove("text-red-800", "bg-red-50", "text-green-800", "bg-green-50")

    if (type === "success") {
      messageDiv.classList.add("text-green-800", "bg-green-50")
    } else {
      messageDiv.classList.add("text-red-800", "bg-red-50")
    }

    setTimeout(() => this.hideMessage(), 5000)
  }

  hideMessage() {
    this.messageTarget.style.display = "none"
  }

  getCSRFToken() {
    return document.querySelector('meta[name="csrf-token"]').content
  }
}